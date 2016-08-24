module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def api_get path, *args
      get "http://api.ubuntu.blog:8080/#{path}", *args
    end

    def api_post path, *args
      post "http://api.ubuntu.blog:8080/#{path}", *args
    end

    def api_login(user)
      post 'http://api.ubuntu.blog:8080/v1/sessions', password: user.password , email: user.email
      json = JSON.parse(response.body)
      json['auth_token']
    end

  end
end