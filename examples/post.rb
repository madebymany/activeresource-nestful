require File.join(File.dirname(__FILE__), *%w[.. lib active_resource nestful])

class Post < ActiveResource::Nestful::Base
  self.site = "http://example.com"
end