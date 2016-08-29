require 'rails_helper'

person = FactoryGirl.build(:person)

RSpec.describe Person, type: :model do
  context 'when has person' do
    it 'should person has name' do 
      expect(person.name).to eq 'John Person'
    end

    it 'should person has email' do 
      expect(person.email).to eq 'john@example.com'
    end

    it "is valid with valid attributes" do
      expect(person).to be_valid
    end

    it "is not valid without a associatons" do
      person = Person.new
      expect(person).to_not be_valid
    end

    describe "Associations" do
      it { should belong_to(:user) }
    end
  end
end
