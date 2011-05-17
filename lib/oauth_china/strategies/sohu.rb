module OauthChina
  class Sohu < OauthChina::OAuth

    def initialize(*args)
      #fuck sohu...!!
      #搜狐微博的OAUTH 只支持将OAuth的认证参数放在HTTP的头部中。而且不可以带realm参数
      self.consumer_options = {
        :site               => 'http://api.t.sohu.com',
        :scheme             => :header,
        :request_token_path => '/oauth/request_token',
        :access_token_path  => '/oauth/access_token',
        :authorize_path     => '/oauth/authorize'
      }
      super(*args)
    end

    def name
      :sohu
    end

    def authorized?
      #TODO
    end

    def destroy
      #TODO
    end

    def add_status(content, options = {})
      options.merge!(:status => content)
      self.post("http://api.t.sohu.com/statuses/update.json", options)
    end

    #TODO
    def upload_image(content, image_path, options = {})
      add_status(content, options)
    end
    
  end
end