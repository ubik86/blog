class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, 
  :recoverable, :rememberable, :trackable, :validatable, 
  :omniauthable, omniauth_providers: [:facebook]

  attr_accessor :gpasswd  # generated passwd
  before_create :generate_password!

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy

  validates :email, uniqueness: { :case_sensitive => false }

  # create User from oAuth response
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end


  def finished_profile?
    self.name? && (self.image? || self.profile_image)
  end

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def ensure_authentication_token
    self.authentication_token = generate_authentication_token
    self.save!
    self.authentication_token
  end

  protected
  # generate password
  def generate_password!
    if password.blank? && password_confirmation.blank?
      pass = Devise.friendly_token.first(8)
      self.password, self.password_confirmation = pass, pass
      self.gpasswd = pass
    end
  end

  # generate unique token
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
