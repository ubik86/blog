require 'rails_helper'

RSpec.describe "Friendships", type: :request do

  before(:example) do
    @user = FactoryGirl.create(:user)
    @person = FactoryGirl.create(:person)
    
    login_as(@user, :scope => :user, :run_callbacks => false)
  end

  describe "GET /friendships/new" do
    it "visit  new_person_friendship site" do 
      visit new_person_friendship_path(@person)
      expect(page).to have_content('friends')
    end

    it "visit fill_in and submit form" do 
      visit new_person_friendship_path(@person)

      fill_in 'Search friends', with: '@btr and @ipr'
      click_button 'Create Friendship'

      expect(page).to have_content('friends')
    end
  end
end
