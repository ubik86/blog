module API
  module V1
    class UsersController < API::BaseController
      before_filter :authenticate_user_from_token!
      before_filter :create_params

      respond_to :json
      
      def index
        if current_user
          render json: {noting:true}
        else
          render json: {}, status: :unauthorized
        end
      end

      def show
        respond_with User.first
      end


      protected
        def create_params
          params.permit(:token)
        end
    end
  end
end