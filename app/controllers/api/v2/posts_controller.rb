module API
  module V2
    class PostsController < API::BaseController
      before_filter :authenticate_user_from_token!
      before_filter :set_posts, only: [:index]

      respond_to :json
      
      def index
      end


      def create
        @post = Post.new(post_params)
        @post.user = current_user

        if @post.save
          render json: {success: true, post: @post}
        else
          render json: {success: false, errors: @post.errors}
        end
      end


      protected

      def post_params
        params.permit(:title, :content, :published, :page)
      end

      def set_posts
        @user = current_user 
        @posts = @user.posts.includes(:comments)
      end
    end
  end
end