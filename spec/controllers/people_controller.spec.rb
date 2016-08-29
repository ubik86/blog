require 'rails_helper'


RSpec.describe PeopleController, type: :controller do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: 'Name', email: Faker::Internet.email, user_id: 1}
  }

  let(:invalid_attributes) {
    {}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController. Be sure to keep this updated too.
  let(:valid_session) {
       {} }

  describe "index action in PeopleController" do

    it "go to index action" do
      get :index, params: {page: 1, search: ''}, session: valid_session
      expect(response.status).to eq(200)
    end
  end
end