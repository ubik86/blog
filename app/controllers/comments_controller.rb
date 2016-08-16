class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_post, only: [:new,:create,:update,:edit]
  before_action :authenticate_user!

  def index

    # load comments belongs to post (or all comments), includes post in one query
    unless params[:post_id].nil?
      @comments = current_user.posts.find(params[:post_id]).comments.includes(:post).page params[:page]
      @post = current_user.posts.find(params[:post_id])
    end

      @comments ||= current_user.comments.includes(:post).page params[:page]
  end


  def show
  end

  def new
    @comment = Comment.new(parent_id: params[:parent_id], post_id: params[:post_id])
  end


  def edit
  end


  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = current_user.posts.find(params[:post_id]) unless params[:post_id].nil?
    
    unless params[:comment].nil? || params[:comment].empty? 
      @post = current_user.posts.find(params[:comment][:post_id]) unless params[:comment][:post_id].nil?
    end

    raise ActiveRecord::RecordNotFound if @post.nil?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:desc,:post_id,:parent_id, :page)
  end
end
