require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before(:each) do
    @user    = FactoryGirl.create(:user)
    @post    = FactoryGirl.create(:post)
    @comment = FactoryGirl.create(:comment)

    login_as(@user, :scope => :user, :run_callbacks => false)
  end


  describe "GET /posts" do
    it "visit post_path site" do 
      visit posts_path;

      expect(page).to have_content('Posts')
    end
  end

  describe "POST /post" do
    it "visit post_path site" do 
      visit posts_path(@post);

      expect(page).to have_content('Posts')
      expect(page).to have_current_path(posts_path(@post))
    end
  end

  describe "CREATE /post" do
    it "visit post_path site" do 
      visit posts_path(@post);

      expect(page).to have_content('Posts')
    end
  end
end
