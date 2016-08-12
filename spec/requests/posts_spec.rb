require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "visit post_path site" do 
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user, :run_callbacks => false)

      visit posts_path;

      expect(page).to have_content('posts')
    end
  end
end
