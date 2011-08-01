module OauthChina
  
  module Multipart

    class Param
      attr_accessor :k, :v
      def initialize(k, v)
        @k = k
        @v = v
      end

      def to_multipart
        #return "Content-Disposition: form-data; name=\"#{CGI::escape(k)}\"\r\n\r\n#{v}\r\n"
        # Don't escape mine...
        return "Content-Disposition: form-data; name=\"#{k}\"\r\n\r\n#{v}\r\n"
      end
    end

    class FileParam
      attr_accessor :k, :filename, :content
      def initialize(k, filename, content)
        @k = k
        @filename = filename
        @content = content
      end

      def to_multipart
        #return "Content-Disposition: form-data; name=\"#{CGI::escape(k)}\"; filename=\"#{filename}\"\r\n" + "Content-Transfer-Encoding: binary\r\n" + "Content-Type: #{MIME::Types.type_for(@filename)}\r\n\r\n" + content + "\r\n "
        # Don't escape mine
        return "Content-Disposition: form-data; name=\"#{k}\"; filename=\"#{filename}\"\r\n" + "Content-Transfer-Encoding: binary\r\n" + "Content-Type: #{MIME::Types.type_for(@filename)}\r\n\r\n" + content + "\r\n"
      end
    end
    class MultipartPost

      BOUNDARY = 'tarsiers-rule0000'
      ContentType = "multipart/form-data; boundary=" + BOUNDARY

      def set_form_data(req, params)
        body, content_type = prepare_query(params)
        req["Content-Type"] = content_type
        req.body = body
        req["Content-Length"] = body.bytesize
        req
      end

      def prepare_query(params)
        fp = []
        params.each {|k,v|
          if v.respond_to?(:read)
            fp.push(FileParam.new(k, v.path, v.read))
            v.close
          else
            fp.push(Param.new(k,v))
          end
        }
        body = fp.collect {|p| "--" + BOUNDARY + "\r\n" + p.to_multipart }.join("") + "--" + BOUNDARY + "--\r\n"
        return body, ContentType
      end


    end
  end
end
