require 'rails_helper'

post = FactoryGirl.build(:post)

RSpec.describe Post, type: :model do
  context 'when has posts' do
    it 'should post has title' do 
      expect(post.title).to eq 'Post'
    end

    it 'should post has content' do 
      expect(post.content).to eq 'Content'
    end

    it 'should post has published' do 
      expect(post.published).to eq false
    end
  end
end
