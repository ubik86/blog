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



# class Friendship::Relation
# has methods that return array of Person objects
#
# Example:
# rel = Friendship::Relation.new Person.first
# rel.friends_of_friend
# rel.mutual_friends

class Friendship::Relation
  attr_accessor :friends, :fof, :fwf, :mf, :ivf

  def initialize(person)
    @person = person
    @friends = @person.friends.includes(:friends)
  end

  # return array friends_of_fr
  def friends_of_friend
    self.fof = @friends.collect{|f| f.friends}.flatten.uniq.delete_if{|f| f == @person}
  end

  def friends_with_friends
    f_o_f = @friends + friends_of_friend
    f_p_f = (@friends+f_o_f).delete_if{|f| f == @person}

    self.fwf = f_p_f.uniq.delete_if{|f| f == @person}
  end

  def mutual_friends
    self.mf = friends_with_friends & @friends   
  end

  def inverse_friends
    self.ivf = @person.inverse_friends
  end
end