gem "nestful"

require "nestful"
require "active_resource"

module ActiveResource
  module Nestful
    class Base < ActiveResource::Base    
      class << self
        
        def oauth(options = nil)
          @oauth = options if options
          
          if block_given?
            yield
            @oauth = nil
          end
          
          if defined?(@oauth)
            @oauth
          elsif superclass != Object && 
                  superclass != ActiveResource::Base && 
                    superclass.oauth
            superclass.oauth.dup.freeze
          end
        end
        
        alias_method :oauth=, :oauth
        
        def format=(mime_type_reference_or_format)
          format = mime_type_reference_or_format.is_a?(Symbol) ?
            ::Nestful::Formats[mime_type_reference_or_format] : mime_type_reference_or_format

          write_inheritable_attribute(:format, format)
          connection.format = format if site
        end
        
        def format
          read_inheritable_attribute(:format) || ::Nestful::Formats::XmlFormat.new
        end
        
        def connection(refresh = false)
          if defined?(@connection) || superclass == Object
            @connection = ActiveResource::Nestful::Connection.new(site, format) if refresh || @connection.nil?
            @connection.proxy = proxy if proxy
            @connection.user = user if user
            @connection.password = password if password
            @connection.auth_type = auth_type if auth_type
            @connection.timeout = timeout if timeout
            @connection.ssl_options = ssl_options if ssl_options
            @connection.oauth = oauth if oauth
            @connection
          else
            superclass.connection
          end
        end
      end
      
      def encode(options = {})
        self.class.format.encode(attributes, options)
      end
    end # Base
  end # Nestful
end # ActiveResource

require File.join(File.dirname(__FILE__), *%w[nestful connection])