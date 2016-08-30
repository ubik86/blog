require "rails_helper"

RSpec.describe StatsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/stats").to route_to("stats#index")
    end

    it "routes to #show" do
      expect(:get => "/stats/1").to route_to("stats#show", id: '1')
    end
  end
end