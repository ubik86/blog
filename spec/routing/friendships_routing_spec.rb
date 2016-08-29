require "rails_helper"

RSpec.describe FriendshipsController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/people/1/friendships").to route_to("friendships#create", person_id: '1')
    end

    it "routes to #new" do
      expect(:get => "/people/1/friendships/new").to route_to("friendships#new", person_id: '1')
    end

    it "routes to #destroy" do
      expect(:delete => "/people/1/friendships/1").to route_to("friendships#destroy", id: '1', person_id: '1')
    end
  end
end
