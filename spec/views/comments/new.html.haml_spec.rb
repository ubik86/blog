require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  before(:each) do
    assign(:comment, Comment.new(
      :desc => "MyString",
      post: FactoryGirl.build(:post)

    ))
  end

  # it "renders new comment form" do
  #   render

  #   assert_select "form[action=?][method=?]", comments_path, "post" do

  #     assert_select "input#comment_desc[name=?]", "comment[desc]"
  #   end
  # end
end
