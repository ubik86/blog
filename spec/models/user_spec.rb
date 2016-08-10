require 'rails_helper'

user = FactoryGirl.build(:user)
user.posts = [FactoryGirl.build(:post)]

RSpec.describe User, type: :model do
  context 'when logged in' do
  	it 'should present posts for user' do 
  		expect(user.password).to eq 'Test123'
  	end

	it 'should have posts' do 
  		expect(user.posts.length).to eq 1
  	end
  end
end
