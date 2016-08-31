class Friendship < ActiveRecord::Base
  belongs_to :person
  belongs_to :friend, class_name:   :Person

  validate :person_is_friend?
  validates :person_id, uniqueness: {scope: [:friend_id]}

  # helper scope methods
  scope :confirmed, -> { where.not(confirmed_at: nil)}
  scope :unconfirmed, -> { where(confirmed_at: nil)}

  attr_accessor :search_friends


  # validates method check that person is a friend
  def person_is_friend?
    if self.person_id == self.friend_id 
      self.errors.add :base, "Person can't be a friend"
      return false
    end
    return true
  end
end
