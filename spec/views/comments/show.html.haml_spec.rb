require 'rails_helper'

RSpec.describe "comments/show", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :desc => "Desc"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Desc/)
  end
end
