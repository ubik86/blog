require 'rails_helper'

RSpec.describe "Friendships", type: :request do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @person = FactoryGirl.create(:person)
    Capybara.javascript_driver = :webkit
    
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

  describe "CREATE /friendships" do
    it "visit  new_person_friendship site" do 
      visit new_person_friendship_path(@person)
      person2 = Person.create(login: 'btr', name: 'btr', email: 'btr@example.com')


      fill_in 'Search friends', with: "@btr and @ipr"
      find('#friendship_friend_id').set(person2.id)
      find('#friendship_person_id').set(@person.id)

      click_button 'Create Friendship'

      expect(page).to have_current_path(person_path(@person))
      expect(page).to have_content('btr')
    end
  end
end
