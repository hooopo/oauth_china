module OauthChina
  class Netease < OauthChina::OAuth

    def initialize(*args)
      #fuck 163
      #这个authorize path不是authorize，是authenticate呀！！！真变态！
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

    #TODO
    def upload_image(content, image_path, options = {})
      add_status(content, options)
    end

  end
end