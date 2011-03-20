module OauthChina
  class QQ < OauthChina::OAuth

    def initialize(*args)
      self.consumer_options = {
        :site => "https://open.t.qq.com",
        :request_token_path  => "/cgi-bin/request_token",
        :access_token_path   => "/cgi-bin/access_token",
        :authorize_path      => "/cgi-bin/authorize",
        :http_method         => :get,
        :scheme              => :query_string,
        :nonce               => nonce,
        :realm               => url
      }
      super(*args)
    end

    def name
      :qq
    end

    def nonce
      Base64.encode64(OpenSSL::Random.random_bytes(32)).gsub(/\W/, '')[0, 32]
    end
      
    def authorized?
      #TODO
    end

    def destroy
      #TODO
    end
  end
end