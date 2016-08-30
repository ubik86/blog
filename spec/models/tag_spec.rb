require 'rails_helper'

tag = FactoryGirl.build(:tag)

RSpec.describe tag, type: :model do
  context 'when has postable' do
    it 'should has post' do 
      expect(tag.postable.class).to eq Post
    end

    it 'should has person' do 
      expect(tag.person.class).to eq Person
    end

    it 'should has user' do 
      expect(tag.user.class).to eq User
    end

    it 'not valid attributes' do
      expect(Tag.new).to_not be_valid
    end

    it 'valid attributes' do
      expect(tag).to be_valid
    end
  end
end