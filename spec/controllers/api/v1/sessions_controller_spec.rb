require 'rails_helper'

RSpec.describe API::V1::SessionsController, type: :controller do
  before(:each) do           
    @user = FactoryGirl.build(:user)
    @user.confirm
    @user.save
  end

  # describe "POST #create" do

  #   context "with invalid params" do
  #     it "assigns a newly created but unsaved post as @post" do
  #       #api_login (@user)

  #       post 'create', password: @user.password , email: @user.email
  #       json = JSON.parse(response.body)
  #       json['auth_token']
  #       # expect(assigns(:post)).to be_a_new(Post)
  #     end

  #     it "re-renders the 'new' template" do
  #       # post :create, {post: invalid_attributes}, session: valid_session
  #       # expect(response).to render_template("new")
  #     end
  #   end
  # end


  # describe "DELETE #destroy" do


  #   # it "destroys the requested resource" do
  #   #   expect {
  #   #     delete :destroy, {id: @user.to_param}
  #   #   }.to change(@user, :token)
  #   # end
  # end
end