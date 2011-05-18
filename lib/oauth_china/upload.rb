module OauthChina
  module Upload
   
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
      multipart_post = Multipart::MultipartPost.new
      multipart_post.set_form_data(req, params)
    end

    def params_without_pic_field(options)
      options.except(:pic)
    end
      
  end
end