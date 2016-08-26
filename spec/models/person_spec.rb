require 'rails_helper'

person = FactoryGirl.build(:person)

RSpec.describe Person, type: :model do
  context 'when has person' do
    it 'should person has name' do 
      expect(person.name).to eq 'John Person'
    end

    it 'should person has login' do 
      # Fix this test with sequence
      # expect(person.login).to eq 'login'
    end

    it 'should person has email' do 
      expect(person.email).to eq 'john@example.com'
    end
  end
end
