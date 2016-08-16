require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, Kaminari.paginate_array([
        Post.create!(
          :title => "Title",
          :content => "MyText",
          :published => false,
          :user => FactoryGirl.build(:user)
        ),
        Post.create!(
          :title => "Title",
          :content => "MyText",
          :published => false,
          :user => FactoryGirl.build(:user)
        )
      ]).page(1))
  end

  it "renders a list of posts" do
    render
    assert_select "h2", :text => "Title".to_s, :count => 2
    assert_select "h3", :text => "MyText".to_s, :count => 2
  end
end
