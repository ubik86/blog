class Friendship < ActiveRecord::Base
  belongs_to :person
  belongs_to :friend, class_name:   :Person

  validates :person, uniqueness: {scope: :friend}

  scope :confirmed, -> { where.not(confirmed_at: nil)}
  scope :unconfirmed, -> { where(confirmed_at: nil)}

  attr_accessor :search_friends
end
