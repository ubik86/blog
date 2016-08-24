module API
  module V1
    class CommentsController < API::BaseController
      before_filter :authenticate_user_from_token!
      before_filter :set_comments, only: [:index]

      respond_to :json
      
      def index
        render json: {success:true, comments: @comments.as_json(include: :post)}
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
        @comments = current_user.comments.includes(:post)
      end
    end
  end
end