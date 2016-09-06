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

  context 'when method period is called' do
    it 'should return posts and comments' do 
      period = @stat.period(:year)

      expect(period[:post]).to eq 3
      expect(period[:comment]).to eq 0
    end

    it 'should return all stats' do 
      all = @stat.all

      expect(all[:year][:post]).to eq 3
      expect(all[:year][:comment]).to eq 0

    end
  end

  context 'when method missing is called' do
    it 'should has implemented method missing' do 
      yearly = @stat.yearly

      expect(yearly[:post]).to eq 3
      expect(yearly[:comment]).to eq 0
    end


    it 'should has raise exception on NoMethodError'  do
      begin
        @stat.missingmethod
      rescue => e
      end

      expect(e.class).to eq NoMethodError

    end
  end

end