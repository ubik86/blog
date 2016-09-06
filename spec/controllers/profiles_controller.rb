require 'rails_helper'


RSpec.describe ProfilesController, type: :controller do
  login_user


  let(:valid_attributes) {
      {name: 'Name', email: 'myemail@example.com', profile: 'profile.jpg'}
  }

  let(:invalid_attributes) {
      {name: '', email: '', profile: ''}
  }

  let(:user) { FactoryGirl.create(:user) }
  let(:current_user) {user}

  describe "PUT #update" do
    let(:user) { FactoryGirl.create(:user) }
    let(:current_user) {user}

    context "with valid params" do
      let(:new_attributes) {
        {name: 'new name', email: 'email@example.com' }
      }

      it "updates the requested profile" do
        profile = current_user
        put :update, {id: profile.to_param, user: new_attributes}
        profile.reload
      end

      # it "assigns the requested profile as @profile" do 
      #   profile = current_user
      #   put :update, {id: profile.to_param, user: valid_attributes}
      #   expect(assigns(:profile)).to eq(profile)
      # end

      # it "redirects to profile" do
      #   profile = current_user

      #   put :update,  {id: profile.to_param, user: valid_attributes}
      #   expect(response).to redirect_to(profile_path(profile))
      # end
    end

    context "with invalid params" do
      # it "assigns the profile as @profile" do
      #   profile = current_user
      #   put :update,  {id: profile.to_param, user: invalid_attributes}
      #   debugger
      #   expect(assigns(:profile)).to eq(profile)
      # end

      it "re-renders the 'edit' template" do
        profile = current_user
        put :update, {id: profile.to_param, user: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end
end