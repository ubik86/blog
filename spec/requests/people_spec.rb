require 'rails_helper'

RSpec.describe "People", type: :request do
  before(:each) do
    @user   = FactoryGirl.create(:user)
    @person = FactoryGirl.create(:person)

    login_as(@user, :scope => :user, :run_callbacks => false)
  end

  describe "GET /people" do
    it "visit people_path site" do 
      visit people_path

      expect(page).to have_content('People')
    end
  end

  describe "Post /people/1" do
    it "visit people_path(person) site" do 
      visit people_path(@person)

      expect(page).to have_content('People')
      expect(page).to have_content('John')
      expect(page).to have_link('friendship')
    end
  end

  describe "Edit /people" do
    it "visit edit_people_path(person) site" do 
      visit edit_person_path(@person)

      expect(page).to have_content('Edit')
    end
  end
end
