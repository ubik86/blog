module API
  module V1
    class UsersController < ApplicationController
      respond_to :json

      def show
        respond_with User.first
      end
      end
  end
end