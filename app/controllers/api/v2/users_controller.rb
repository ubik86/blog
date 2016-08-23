module API
  module V2
    class UsersController < ApplicationController
      respond_to :json

      def show
        respond_with User.last
      end
      end
  end
end