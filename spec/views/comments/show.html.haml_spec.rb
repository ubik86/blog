require 'rails_helper'

RSpec.describe "comments/show", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      desc: "MyString",
      user: FactoryGirl.build(:user),
      post: FactoryGirl.build(:post)
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Desc/)
  end
end
