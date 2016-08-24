require 'rails_helper'

describe "Sessions API" do
  before(:each) do
    @post = FactoryGirl.build(:post)
    @user = FactoryGirl.build(:user)
    @user.confirm
    @user.save

    @token = api_login(@user)
    3.times {|i|  @user.posts.create(title: "title #{i}", content: "content #{i}")}
  end


  it 'GET posts#index without login user # auth_token' do
    api_get 'v1/posts', token: @token
    json = JSON.parse(response.body)

    expect(response).to have_http_status(200)

    expect(json['success']).to eq true
    expect(json['posts'].length).to eq 3
  end

  it 'Create new post with POST posts#create after login user, create posts' do
    api_post 'v1/posts', token: @token, user_id: @user.id, title: @post.title, content: @post.content, published: @post.published
    json = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(json['success']).to eq true
    expect(json['post']['user_id']).to eq @user.id
    expect(json['post']['title']).to eq @post.title
  end
end