set :haml, :format => :html5

configure do
  set :public_folder, 'public'
  set :views, 'app/views'
end

get "/" do
  haml :welcome
end

not_found do
  haml :e404
end
