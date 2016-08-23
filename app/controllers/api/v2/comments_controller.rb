module API
  module V2
    class CommentsController < API::BaseController
      before_filter :authenticate_user_from_token!

      before_filter :set_comments, only: [:index]

      respond_to :json
      
      def index
      end


      def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user

        if @comment.save
          render json: {success: true, comment: @comment}
        else
          render json: {success: false, errors: @comment.errors}
        end
      end


      protected
      def comment_params
        params.permit(:desc,:post_id,:parent_id,:ancestry)
      end
      def set_comments
        @user = current_user 
        @comments = @user.comments.includes(:post)
      end
    end
  end
end