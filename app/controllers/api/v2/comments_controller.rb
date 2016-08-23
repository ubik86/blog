module API
  module V2
    class CommentsController < API::BaseController
      before_filter :authenticate_user_from_token!
      before_filter :create_params, only: [:index]
      before_filter :set_comments

      respond_to :json
      
      def index
        #render json: {success:true, comments: @comments.as_json(include: :post)}
      end


      def create
        render json: {}
      end


      protected
      def create_params
        params.permit(:token)
      end

      def set_comments
        @user = current_user 
        @comments = @user.comments.includes(:post)
      end
    end
  end
end