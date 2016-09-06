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

  context 'new users' do
    it "orders email" do
      lindeman = User.create!(email: 'abc@example.com', password: 'test123')
      chelimsky = User.create!(email: 'xyz@example.com', password: 'test123')

      expect(User.order(:email).map{|a| a.email.split('@').first}).to eq(['abc', 'xyz'])
    end

    it 'should has password_match? as true' do
      match = user.password_match?
      expect(match).to eq true
    end

    it 'should has finished_profile? as true' do
      match = user.finished_profile?
      expect(match).to eq nil
    end

    it 'should has profile_image? as true' do
      img = user.profile_img
      expect(img).to eq user.profile_image
    end

  end
end
