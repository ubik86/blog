require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  login_user


  let(:user) { FactoryGirl.create(:user) }
  let(:current_user) {user}

  let(:valid_attributes) {
      {id: 1, person_id: 2, friend_id:1, accepted: true}
  }

  let(:invalid_attributes) {
    {}
  }


  describe "DELETE #destroy" do
    before(:each) { @friendship = Friendship.create! valid_attributes  }
    
    it "destroys the requested friendship" do
      expect {
        delete :destroy, {id: @friendship.to_param, person_id: @friendship.person_id, format: :js}
      }.to change(Friendship, :count).by(-1)
    end

    it "redirects to the friendship list" do
      delete :destroy, {id: @friendship.to_param, person_id: @friendship.person_id, format: :js}
      expect(response).to render_template(:destroy)
    end
  end
end