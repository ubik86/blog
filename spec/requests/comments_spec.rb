require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before(:each) do
    @user    = FactoryGirl.create(:user)
    @post    = FactoryGirl.create(:post)
    @comment = FactoryGirl.create(:comment)

    login_as(@user, :scope => :user, :run_callbacks => false)
  end

  describe "GET /comments" do
    it "visit people_path site" do 
      visit comments_path

      expect(page).to have_content('Comment')
      expect(page).to have_current_path(comments_path)
    end
  end

  describe "POST /comment/1" do
    it "visit people_path(person) site" do 
      visit comments_path(@comment)

      expect(page).to have_current_path(comments_path(@comment))
    end
  end
end
