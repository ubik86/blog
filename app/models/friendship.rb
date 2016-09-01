class Friendship < ActiveRecord::Base
  belongs_to :person
  belongs_to :friend, class_name:   :Person

  validate  :person_is_friend?
  validates :person_id, uniqueness: {scope: [:friend_id]}
  validate :friends_now?

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


  def friends_now?
    rel = Friendship.where(person_id: [self.person_id, self.friend_id], friend_id:[self.friend_id, self.person_id])
    unless rel.empty?
      self.errors.add :base, "@#{self.person.login} and @#{self.friend.login} are already friends"
      return false
    end

    return true
  end

end



# class Friendship::Relation
# has few methods that return array of Person related objects
#
# Example:
# rel = Friendship::Relation.new Person.first
# rel.friends_of_friend
# rel.mutual_friends

class Friendship::Relation
  attr_accessor :friends, :fof, :fwf, :mf, :ivf

  def initialize(person)
    @person = person
    @friends ||= @person.all_friends
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
end