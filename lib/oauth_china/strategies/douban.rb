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
      #TODO
    end

    def destroy
      #TODO
    end
  end
end