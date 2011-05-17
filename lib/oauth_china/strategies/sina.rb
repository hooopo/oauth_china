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


    def upload_image(content, image_path, options = {})
      options = options.merge!(:status => content, :pic => File.open(image_path, "rb")).to_options
      upload("http://api.t.sina.com.cn/statuses/upload.json", options)
    end

    #NOTICE：
    #各个微博字段名可能不统一
    def upload(url, options)
      url  = URI.parse(url)
      http = Net::HTTP.new(url.host, url.port)
      
      req  = Net::HTTP::Post.new(url.request_uri)
      req  = sign_without_pic_field(req, self.access_token, options)
      req  = set_multipart_field(req, options)
      
      http.request(req)
    end

    #图片不参与签名
    def sign_without_pic_field(req, access_token, options)
      req.set_form_data(params_without_pic_field(options))
      self.consumer.sign!(req, access_token)
      req
    end

    #mutipart编码：http://www.ietf.org/rfc/rfc1867.txt
    def set_multipart_field(req, params)
      multipart_post = MultipartPost.new
      multipart_post.set_form_data(req, params)
    end

    def params_without_pic_field(options)
      options.except(:pic)
    end

  end
end