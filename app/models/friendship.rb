class Friendship < ActiveRecord::Base
  belongs_to :person
  belongs_to :friend, class_name:   :Person

  validates :person, uniqueness: {scope: :friend}

  attr_accessor :search_friends
end
