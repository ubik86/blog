require 'rails_helper'

post = FactoryGirl.build(:post)

RSpec.describe Post, type: :model do
  context 'when logged in' do
    it 'should present posts for user' do 
      expect(post.title).to eq 'Post'
    end
  end
end
