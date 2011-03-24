module OauthChina
  class Sina < OauthChina::OAuth
      
    def initialize(*args)
      self.consumer_options = {
        :site               => 'http://api.t.sina.com.cn',
        :request_token_path => '/oauth/request_token',
        :access_token_path  => '/oauth/access_token',
        :authorize_path     => '/oauth/authorize',
        :realm              => url
      }
      super(*args)
    end

    def name
      :sina
    end

    def authorized?
      #TODO
    end

    def destroy
      #TODO
    end

    def add_status(content, options = {})
      options.merge!(:status => content)
      self.post("http://api.t.sina.com.cn/statuses/update.json", options)
    end
  end
end