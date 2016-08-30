class Tag < ActiveRecord::Base
  belongs_to :postable, polymorphic: true
  belongs_to :person
  belongs_to :user

  validates :postable, presence: true
  validates :person, presence: true
  validates :user, presence: true

  validates_associated :postable
  validates_associated :person
  validates_associated :user
end
