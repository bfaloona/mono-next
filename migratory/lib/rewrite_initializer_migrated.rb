
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

module RewriteInitializer
  # This module registers a Rack::Rewrite middleware with Sinatra
  def self.registered(app)
    app.use Rack::Rewrite do
      # This rewrites '/wiki/John_Trupiano' to '/john'
      rewrite '/wiki/John_Trupiano', '/john'
      # This performs a permanent redirect from '/wiki/Yair_Flicker' to '/yair'
      r301 '/wiki/Yair_Flicker', '/yair'
      # This performs a temporary redirect from '/wiki/Greg_Jastrab' to '/greg'
      r302 '/wiki/Greg_Jastrab', '/greg'
      # This performs a permanent redirect from any '/wiki/[word]_[word]' to '/[word]'
      r301 %r{/wiki/(\w+)_\w+}, '/$1'
    end
  end
end