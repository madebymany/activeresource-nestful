require File.join(File.dirname(__FILE__), *%w[.. lib active_resource nestful])
require "nestful/oauth"

class Post < ActiveResource::Nestful::Base
  self.site = "http://example.com"
end

Post.oauth(
  :consumer_key    => AppConfig.oauth_consumer_key,
  :consumer_secret => AppConfig.oauth_consumer_secret,
  :access_key      => AppConfig.oauth_access_key,
  :access_secret   => AppConfig.oauth_access_secret
) do
  Post.all
end