class Person < ActiveRecord::Base
  has_many :tags
  has_many :posts, as: :postable

  #Friendship assciations
  has_many :friendships
  has_many :friends,        through: :friendships

  has_many :inverse_friendships,  foreign_key: :friend_id, class_name:  :Friendship
  has_many :inverse_friends,    through: :inverse_friendships, source: :person

  #has_many :posts, through: :tags, class_name: Post, :as 
end