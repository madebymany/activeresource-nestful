module ActiveResource
  module Nestful
    class Connection
      class Result
        attr_reader :body
        
        def initialize(body)
          @body = body
        end
      end
  
      def initialize(site, format = :xml)
        @options = {}
        @site    = site
        @options[:format] = format
      end
    
      def get(path, headers = {})
        format.decode(request(path, :headers => headers).body)
      end
  
      def delete(path, headers = {})
        request(path, :method => :delete, :headers => headers)
      end
  
      def put(path, body = '', headers = {})
        request(path, :method => :put, :body => body, :headers => headers)
      end
  
      def post(path, body = '', headers = {})
        request(path, :method => :post, :body => body, :headers => headers)
      end
  
      def head(path, headers = {})
        request(path, :method => :head, :headers => headers)
      end
      
      def method_missing(name, *args)
        if name.to_s =~ /=$/
          @options[$`.to_sym] = args.first
        elsif @options.has_key?(name)
          @options[name]
        else
          super
        end
      end
  
      private
        def request(path, options = {})
          request = ::Nestful::Request.new(@site.dup + path, options.merge(@options))
          Result.new(request.execute)
        end
    end
  end
end