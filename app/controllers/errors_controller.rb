class ErrorsController < ApplicationController
 
   def show
    flash.alert = "Status #{status_code}"
    render status_code.to_s, :status => status_code, layout: :errors
  end
 
  protected
 
  def status_code
    params[:code] || 500
  end

end