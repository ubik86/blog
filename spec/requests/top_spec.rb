require 'rails_helper'

RSpec.describe "Top", type: :request do

  describe "access top page" do
    mock_auth_hash

    it "can sign in user with Facebook account" do
      visit '/'
      expect(page).to have_content("Sign in with Facebook")

      click_link "Sign in with Facebook"
      expect(page).to have_content("Successfully authenticated")  # user name
      expect(page).to have_content("Log Out")
    end

    it "can handle authentication error" do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
      visit '/'
      expect(page).to have_content("Sign in with Facebook")
      click_link "Sign in with Facebook"
    end
  end
end