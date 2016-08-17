require 'rails_helper'



RSpec.describe Comment, type: :model do

  before :each do 
    @comment = FactoryGirl.build(:comment)
    @post = FactoryGirl.build(:post)
    @comment.post = @post
    @comment.save!

    3.times{|i| @comment.children.create desc: "desc #{i}", post: @post }

    @comment.save!
  end


  context 'when logged in' do
    it 'should present comments for user' do 
      expect(@comment.desc).to eq 'MyString'
    end

    it 'should have post belongs_to comment' do 
      expect(@comment.post).to eq @post
    end

    it 'should have 3 children' do 
      expect(@comment.children.size).to eq 3
    end
  end
end
