module API
  class BaseController < ApplicationController
    skip_before_filter :verify_authenticity_token, :only => :create


    protected


    def authenticate_user_from_token!
      token = params[:token].presence
      user = token && User.where(authentication_token: token).first

      if user
        sign_in user, store: false
      else
        render(json: {success: false, message: "Unauthenticated access"}, status: 401)
      end
    end

    def create_params
      params.permit(:token)
    end

  end
end