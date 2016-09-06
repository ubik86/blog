class ApplicationController < ActionController::Base
  include ExceptionLogger::ExceptionLoggable
  rescue_from Exception, :with => :log_exception_handler # tells rails to forward the 'Exception' (you can change the type) to the handler of the module

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

end