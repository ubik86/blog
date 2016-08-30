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


    it 'should has 3 comments' do 
      3.times{|i| post.comments << FactoryGirl.build(:comment) }
      expect(post.comments.size).to eq 3
      expect(post.c_quantity).to eq 3
    end


    it 'should find taggable' do 
      valid_content = 'sample content @login1 and @bad_login'
      person = Person.create(name: 'Login1', login: 'login1', email: 'login1@example.com')

      expect(Post.find_taggable(valid_content)).to eq({found: [person], not_found: ['bad_login']})
    end


    it 'should search Post via override self.search method' do 
      post = FactoryGirl.create(:post)
      expect(Post.search('Content')).to eq [post]
    end

  end
end
