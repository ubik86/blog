class Stat
  include ActiveModel::Model

  attr_accessor :yearly, :monthly, :weekly, :daily
  attr_accessor :posts, :comments

  def initialize
    init_models

  end


  protected

  def init_models
    @post = Post.all
    @comment = Comment.all
  end
end