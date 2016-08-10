require 'rails_helper'

user = FactoryGirl.build(:user)
user.posts = [FactoryGirl.build(:post)]

admin = FactoryGirl.build(:admin)

RSpec.describe User, type: :model do
  context 'when logged in' do
  	it 'should present posts for user' do 
  		expect(user.password).to eq 'Test123'
  	end

	it 'should have posts' do 
  		expect(user.posts.length).to eq 1
  	end

	it 'user shouldnt be admin' do 
  		expect(user.admin?).not_to eq true
  	end

  	it 'should be admin' do 
  		expect(admin.admin?).to eq true
  	end
  end
end
