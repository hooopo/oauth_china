module OauthChina
  class Douban < OauthChina::OAuth

    def initialize(*args)
      self.consumer_options = {
        :signature_method   => "HMAC-SHA1",
        :site               => "http://www.douban.com",
        :scheme             => :header,
        :request_token_path => '/service/auth/request_token',
        :access_token_path  => '/service/auth/access_token',
        :authorize_path     => '/service/auth/authorize',
        :realm              => url
      }
      super(*args)
    end

    def name
      :douban
    end

    def authorized?
      return false if access_token.nil?
      response = self.get("/access_token/#{access_token.token}")
      response.code == '200'
    end

    def destroy
      destroy_access_key if !access_token.nil?
      request_token = access_token = nil
    end

    protected
    def destroy_access_key
      response = delete("/access_token/#{access_token.token}")
      response.code == '200'
    end
  end
end