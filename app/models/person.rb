class Person < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

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


  # return friends and inverse_friends
  def all_friends
    (friends.all + inverse_friends.all).uniq
  end
  

  def fof
    rel     = Friendship::Relation.new(self)
    f       = rel.friends
    f_o_f   = rel.friends_of_friend
    f_w_f   = rel.friends_with_friends
    mf      = rel.mutual_friends

    {friends: f, fof: f_o_f, fwf: f_w_f, mf: mf}
  end
end