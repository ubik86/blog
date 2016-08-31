require "rails_helper"

RSpec.describe API::V1::PostsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "http://api.ubuntu.blog:8080/v1/posts").to route_to("api/v1/posts#index", format: :json, subdomain: 'api')
    end

    it "routes to #create" do
      expect(post: "http://api.ubuntu.blog:8080/v1/posts").to route_to("api/v1/posts#create", format: :json, subdomain: 'api')
    end

  end
end