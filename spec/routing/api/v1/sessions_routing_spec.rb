require "rails_helper"

RSpec.describe API::V1::SessionsController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(post: "http://api.ubuntu.blog:8080/v1/sessions").to route_to("api/v1/sessions#create", format: :json, subdomain: 'api')
    end
  end
end