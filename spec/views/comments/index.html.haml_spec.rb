require 'rails_helper'

RSpec.describe "comments/index", type: :view do
  before(:each) do
    assign(:comments, Kaminari.paginate_array([
      Comment.create!(
        :desc => "Desc",
        user: FactoryGirl.build(:user),
        post: FactoryGirl.build(:post)
      ),
      Comment.create!(
        :desc => "Desc",
        user: FactoryGirl.build(:user),
        post: FactoryGirl.build(:post)
      )
    ]).page(1))
  end

  it "renders a list of comments" do
    render
    assert_select "h2", :text => "Desc".to_s, :count => 2
  end
end
