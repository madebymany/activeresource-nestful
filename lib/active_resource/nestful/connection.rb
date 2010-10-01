module ActiveResource
  module Nestful
    class Connection
  
      def initialize(site, format = :xml)
        @options = {}
        @site    = site
        @options[:format] = format
      end
  
      def site=(site)
        @site = site
      end
  
      def timeout=(timeout)
        @options[:timeout] = options
      end
  
      def ssl_options=(options)
        @options[:ssl_options] = options
      end
  
      def user=(user)
        @options[:user] = user
      end
  
      def password=(password)
        @options[:password] = password
      end
  
      def auth_type=(type)
        @options[:auth_type] = type
      end
  
      def proxy=(proxy)
        @options[:proxy] = proxy
      end
    
      def oauth=(options)
        @options[:oauth] = options
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
  
      private
        def request(path, options = {})
          address      = @site.dup
          address.path = path
          ::Nestful::Request.new(address, options.merge(@options))
        end
    end
  end
end