module API
  module V1
    class SessionsController < Devise::RegistrationsController
      prepend_before_filter :require_no_authentication, only: [:create]
      before_filter :create_params, only: [:create]
      before_filter :ensure_params_exist
      skip_before_filter :verify_authenticity_token, :only => :create
      include Devise::Controllers::Helpers


      def create
        build_resource
        resource = User.find_for_database_authentication(email: params[:email])

        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:password])
          sign_in("user", resource)
          token = resource.ensure_authentication_token

          render(json: {success: true, auth_token: token, login: resource.email})
          return
        end
        invalid_login_attempt
      end

      def destroy
        sign_out(resource_name)
      end

      protected
        def ensure_params_exist
          return unless params[:email].blank?
          render(json: {success: false, message: "missing email parameter"}, status: 422) and return
          return unless params[:password].blank?
          render(json: {success: false, message: "missing password parameter"}, status: 422) 
        end

        def invalid_login_attempt
          warden.custom_failure!
          render(json: {success: false, message: "Error with your login or password"}, status: 401)
        end

      private
        def create_params
          params.permit(:email, :password)
        end
    end
  end
end