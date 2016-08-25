class Tag < ActiveRecord::Base
  belongs_to :postable, polymorphic: true
  belongs_to :person
  belongs_to :user

end
