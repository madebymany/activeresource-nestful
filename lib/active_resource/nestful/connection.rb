module ActiveResource
  module Nestful
    class Connection  
      def initialize(site, format = :xml, options = {})
        @options = options
        @site    = site
        @options[:raw]    = true
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
        def format
          @options[:format]
        end
      
        def request(path, options = {})
          ::Nestful::Request.new(@site.dup + path, options.merge(@options)).execute
        end
    end
  end
end
