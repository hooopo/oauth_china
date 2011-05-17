module OauthChina
  class Qq < OauthChina::OAuth

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

    #腾讯的nonce值必须32位随机字符串啊！
    def nonce
      Base64.encode64(OpenSSL::Random.random_bytes(32)).gsub(/\W/, '')[0, 32]
    end
      
    def authorized?
      #TODO
    end

    def destroy
      #TODO
    end

    def add_status(content, options = {})
      options.merge!(:content => content)
      self.post("http://open.t.qq.com/api/t/add", options)
    end

    #TODO
    #还未实现
    def upload_image(content, image_path, options = {})
      add_status(content, options)
    end

    #    def upload_image(content, image_path, options = {})
    #      options = options.merge!(:content => content, :pic => File.open(image_path, "rb")).to_options
    #
    #      upload("http://open.t.qq.com/api/t/add_pic", options)
    #    end
    #
    #    def upload(url, options)
    #      url  = URI.parse(url)
    #      http = Net::HTTP.new(url.host, url.port)
    #      req  = Net::HTTP::Post.new(url.request_uri)
    #      req  = sign_without_pic_field(req, self.access_token, options)
    #      req  = set_multipart_field(req, options)
    #
    #      http.request(req)
    #
    #    end
    #
    #    def sign_without_pic_field(req, access_token, options)
    #      req.set_form_data(params_without_pic_field(options))
    #      self.consumer.sign!(req, access_token)
    #      req
    #    end
    #
    #    def set_multipart_field(req, params)
    #      multipart_post = MultipartPost.new
    #      multipart_post.set_form_data(req, params)
    #    end
    #
    #    def params_without_pic_field(options)
    #      options.except(:pic)
    #    end

  end
end