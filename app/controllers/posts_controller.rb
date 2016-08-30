class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  #include PostsHelper

  def index
    @posts = current_user.posts.search(params[:search]).includes(:comments).page params[:page]
  end

  def show
    @tags = @post.tags.includes(:person)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        create_tags

        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update

    respond_to do |format|
      if @post.update(post_params)
        @post.tags.each{|t| t.destroy}
        create_tags

        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = current_user.posts.find(params[:id])
    redirect_to root_path if @post.nil?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :content, :published, :page)
  end

  # Create tags for people founded in post
  def create_tags
    @people = Post.find_taggable(@post.content)

    @people[:found].each do |person|
      @post.tags.create(person: person, user: @post.user)
    end

    @post.tags
  end

end
