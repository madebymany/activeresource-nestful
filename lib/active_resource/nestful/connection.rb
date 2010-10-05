module ActiveResource
  module Nestful
    class Connection
  
      def initialize(site, format = :xml)
        @options = {}
        @site    = site
        @options[:format] = format
      end
    
      def get(path, headers = {})
        request(path, :headers => headers).execute
      end
  
      def delete(path, headers = {})
        request(path, :method => :delete, :headers => headers).execute
      end
  
      def put(path, body = '', headers = {})
        request(path, :method => :put, :body => body, :headers => headers).execute
      end
  
      def post(path, body = '', headers = {})
        request(path, :method => :post, :body => body, :headers => headers).execute
      end
  
      def head(path, headers = {})
        request(path, :method => :head, :headers => headers).execute
      end
      
      def method_missing(name, *args)
        if name.to_s =~ /=$/
          @options[$`.to_sym] = args.first
        else
          super
        end
      end
  
      private
        def request(path, options = {})
          ::Nestful::Request.new(@site.dup + path, options.merge(@options))
        end
    end
  end
end