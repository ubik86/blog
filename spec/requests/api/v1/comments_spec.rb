require 'rails_helper'

describe "Sessions API" do
  before(:each) do
    @comment = FactoryGirl.build(:comment)
    @post = FactoryGirl.build(:post)
    @user = FactoryGirl.build(:user)
    @user.confirm
    @user.save
    @post.save

    @token = api_login(@user)
    #3.times {|i|  @user.comments.create(desc: "description #{i}", post_id: 1)}
  end


  it 'GET comments#index without login user # auth_token' do
    api_get 'v1/comments', token: @token
    json = JSON.parse(response.body)

    expect(response).to have_http_status(200)


    expect(json['success']).to eq true

    # TODO Fix spec to return comments
    expect(json['comments'].length).to eq 0
  end

  it 'Create new post with POST posts#create after login user, create posts' do
    api_post 'v1/comments', token: @token, user_id: @user.id, desc: @comment.desc, post_id: @post.id
    json = JSON.parse(response.body)
    expect(response).to have_http_status(200)
    expect(json['success']).to eq true
    expect(json['comment']['user_id']).to eq @user.id
    expect(json['comment']['post_id']).to eq @post.id
    expect(json['comment']['desc']).to eq @comment.desc
  end
end