require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  before(:each) do
    @post = FactoryGirl.build(:post)
    assign(:comment, Comment.new(
      desc: "MyString",
      user: FactoryGirl.build(:user),
      post: FactoryGirl.build(:post)
    ))
  end

  it "renders new comment form" do

    render
    assert_select "form[action=?][method=?]", '/comments', "post" do

      assert_select "input#comment_desc[name=?]", "comment[desc]"
    end
  end
end
