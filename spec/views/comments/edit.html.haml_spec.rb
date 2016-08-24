require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      desc: "MyString",
      user: FactoryGirl.build(:user),
      post: FactoryGirl.build(:post)
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "input#comment_desc[name=?]", "comment[desc]"
    end
  end
end
