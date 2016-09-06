require 'rails_helper'

RSpec.describe API::V2::SessionsController, type: :controller do
  before(:each) do           
    @user = FactoryGirl.build(:user)
    @user.confirm
    @user.save
  end
end