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

    #网易微博发送带图片的微博需要两个步骤：
    #1.利用上传图片接口上传图片，并取得返回的image url
    #2.把取来的image url放到微博的内容中，利用发微博接口发送微博。
    #3.注意：如果把站外图片链接放到微博里发送不会在web页面中显示
    def upload_image(content, image_path, options = {})
      options = options.merge!(:pic => File.open(image_path, "rb")).to_options
      image_url = parse_image_url(just_upload_image(image_path))
      add_status("#{image_url} #{content}", options)
    end

    private

    def just_upload_image(image_path)
      upload("http://api.t.163.com/statuses/upload.json", :pic => File.open(image_path, "rb"))
    end

    def parse_image_url(resp)
      hash_body = JSON.parse(resp.body)
      if hash_body["error"]
        raise hash_body["error"]
      else
        hash_body["upload_image_url"]
      end
    end

  end
end