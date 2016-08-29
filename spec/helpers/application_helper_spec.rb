require 'rails_helper'
require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationsHelper. For example:
#
#controller.controller_name = 'posts'

RSpec.describe ApplicationHelper, type: :helper do
  describe "if controller_name == name print active" do
    before do
      allow(controller).to receive(:controller_name).and_return('posts')
    end

    it "return  active controller" do

      expect(helper.active_controller('posts')).to eq('active')
    end
  end
end
