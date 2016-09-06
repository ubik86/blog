require 'rails_helper'

RSpec.describe "errors", :type => :request do

  it "displays the 500 page" do
    visit "http://ubuntu.blog:8080/500"
    
    expect(page).to have_content('Status 500')
    expect(page).to have_content('Errors')
  end

  it "displays the 404 page" do
    visit "http://ubuntu.blog:8080/404"
    
    expect(page).to have_content('Status 404')
    expect(page).to have_content('Errors')
  end
end