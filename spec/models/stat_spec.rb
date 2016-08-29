require 'rails_helper'


RSpec.describe Comment, type: :model do

  before :each do 
    @stat = FactoryGirl.build(:stat)
    3.times{|i| @stat.posts << FactoryGirl.build(:post) }
    3.times{|i| @stat.comments << FactoryGirl.build(:comment) }
  end


  context 'when Stat.new is called' do
    it 'should has posts' do 
      expect(@stat.posts.first.title).to eq 'Post'
      expect(@stat.posts.size).to eq 3
    end

    it 'should has comments' do 
      expect(@stat.comments.first.desc).to eq 'MyString'
      expect(@stat.comments.size).to eq 6
    end
  end
end