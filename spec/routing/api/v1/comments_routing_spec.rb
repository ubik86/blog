require "rails_helper"

RSpec.describe API::V1::CommentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "http://api.ubuntu.blog:8080/v1/comments").to route_to("api/v1/comments#index", format: :json, subdomain: 'api')
    end

    it "routes to #create" do
      expect(post: "http://api.ubuntu.blog:8080/v1/comments").to route_to("api/v1/comments#create", format: :json, subdomain: 'api')
    end

  end
end