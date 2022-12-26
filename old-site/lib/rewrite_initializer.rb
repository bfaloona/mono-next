module RewriteInitializer
  def self.registered(app)
    app.use Rack::Rewrite do
      # rewrite '/wiki/John_Trupiano', '/john'
      # r301 '/wiki/Yair_Flicker', '/yair'
      # r302 '/wiki/Greg_Jastrab', '/greg'
      # r301 %r{/wiki/(w+)_w+}, '/$1'
    end

  end
end
