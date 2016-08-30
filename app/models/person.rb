class Person < ActiveRecord::Base
  belongs_to :user

  has_many :tags
  has_many :posts, as: :postable

  #Friendship assciations
  has_many :friendships

  has_many :friends,                  through: :friendships

  # helper relations friendships
  has_many :confirmed_friendships,  -> {confirmed}, class_name: :Friendship
  has_many :confirmed_friends,        through: :confirmed_friendships, source: :friend

  has_many :unconfirmed_friendships,  -> {unconfirmed}, class_name: :Friendship
  has_many :unconfirmed_friends,        through: :unconfirmed_friendships, source: :friend

  # helper relations inverse friendships
  has_many :inverse_friendships,  foreign_key: :friend_id, class_name:  :Friendship
  has_many :inverse_friends,    through: :inverse_friendships, source: :person

  has_many :unconfirmed_inv_friendships,  -> {unconfirmed}, class_name: :Friendship, foreign_key: :friend_id
  has_many :unconfirmed_inv_friends,        through: :unconfirmed_inv_friendships, source: :person


  # validations
  #validates :name, length: 2..30, scope: :login
  validates :login, uniqueness: true, presence: true


  # override default search method
  def self.search(search)
    where(["login LIKE ?  OR name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}"])
  end


  def confirmed_friend?(friend)
    friendships = self.friendships.where(friend_id: friend)
    confirmed = false

    if ! friendships.empty?
      confirmed = true unless friendships.first.confirmed_at.nil?
    end

    return confirmed
  end
  
  # This method find Friends of Friend, will return a hash with keys describe below
  # 
  # friends: friends
  # fof: friends of friends
  # fwf: friends of friends with my friends
  # mf: mutual friends
  # }
  def fof
    f       = self.friends.includes(:friends)
    f_o_f   = f.collect{|f| f.friends}.flatten.uniq.delete_if{|f| f == self}
    f_p_f   = (f+f_o_f).delete_if{|f| f == self}
    f_w_f   = f_p_f.uniq.delete_if{|f| f == self}
    mf      = f_o_f & f
    iv_f    = self.inverse_friends

    {friends: f, fof: f_o_f, fwf: f_w_f, mf: mf, iv_f: iv_f}
  end
end