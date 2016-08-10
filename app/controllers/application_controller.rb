class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception





  protected
  def loadposts
    redirect_to posts_path if user_signed_in?
  end

end
