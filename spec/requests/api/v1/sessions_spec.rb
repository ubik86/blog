require 'rails_helper'


describe "Sessions API" do
  before(:each) do
    @user = FactoryGirl.build(:user)
    @user.confirm
    @user.save
  end


  it 'GET posts#index without login user # auth_token' do
    #FactoryGirl.create_list(:message, 10)

    api_get 'v1/posts'

    json = JSON.parse(response.body)

    expect(response).to have_http_status(401)
    expect(json['success']).to eq false
    expect(json['message']).to eq('Unauthenticated access')
  end

  it 'GET posts# index  after login user' do
    post 'http://api.ubuntu.blog:8080/v1/sessions', password: @user.password , email: @user.email
    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to have_http_status(200)
    expect(json['success']).to eq true
    expect(json['login']).to eq @user.email
    expect(json['auth_token'].length).to be > 10
  end
end