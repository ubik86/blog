class Person < ActiveRecord::Base
  belongs_to :user

  has_many :tags
  has_many :posts, as: :postable

  #Friendship assciations
  has_many :friendships
  has_many :friends,        through: :friendships

  has_many :inverse_friendships,  foreign_key: :friend_id, class_name:  :Friendship
  has_many :inverse_friends,    through: :inverse_friendships, source: :person

  # validations
  #validates :name, length: 2..30, scope: :login
  validates :login, uniqueness: true, presence: true


  def self.search(search)
    where(["login LIKE ?  OR name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}"])
  end

  #return HASH {
  # friends: friends
  # fof: friends of friends
  # fwf: friends of friends with my friends
  # mf: mutual friends
  # }
  def fof
    f       = self.friends.includes(:friends)
    f_o_f   = f.collect{|f| f.friends}.flatten.uniq
    f_p_f   = (f+f_o_f)
    f_w_f   = f_p_f.uniq
    mf      = f_o_f & f

    {friends: f, fof: f_o_f, fwf: f_w_f, mf: mf}
  end
end