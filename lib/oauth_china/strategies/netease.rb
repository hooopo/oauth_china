module OauthChina
  class Netease < OauthChina::OAuth

    def initialize(*args)
      #fuck 163
      #authenticate
      self.consumer_options = {
        :site               => 'http://api.t.163.com',
        :request_token_path => '/oauth/request_token',
        :access_token_path  => '/oauth/access_token',
        :authorize_path     => '/oauth/authenticate',
        :realm              => url
      }
      super(*args)
    end

    def name
      :netease
    end

    def authorized?
      #TODO
    end

    def destroy
      #TODO
    end

    def add_status(content, options = {})
      options.merge!(:status => content)
      self.post("http://api.t.163.com/statuses/update.json", options)
    end
  end
end