require 'rails_helper'

friendship = FactoryGirl.build(:friendship)

RSpec.describe Friendship, type: :model do
  context 'when has friendship' do
    it 'should has person' do 
      expect(friendship.person.class).to eq Person
    end

    it 'should has friend' do 
      expect(friendship.friend.class).to eq Person
    end
  end
end