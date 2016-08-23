module API
  module V2
    class PostsController < API::BaseController
      before_filter :authenticate_user_from_token!
      before_filter :create_params, only: [:index]
      before_filter :set_posts

      respond_to :json
      
      def index
        #render json: {success:true, posts: @posts.as_json(include: :comments)}
      end


      def create
        render json: {}
      end


      protected
      def create_params
        params.permit(:token)
      end

      def set_posts
        @posts = current_user.posts.includes(:comments)
      end
    end
  end
end