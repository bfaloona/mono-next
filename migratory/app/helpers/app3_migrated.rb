# Redirects for Padrino 0.13 URLs
get '/plays/5' do
  redirect r301 '/women/plays/5'
end
get '/plays/7' do
  redirect r301 '/women/plays/7'
end
get '/plays/14' do
  redirect r301 '/women/plays/14'
end
get '/plays/17' do
  redirect r301 '/women/plays/17'
end
get '/plays/15' do
  redirect r301 '/women/plays/15'
end
get '/plays/8' do
  redirect r301 '/women/plays/8'
end
get '/plays/16' do
  redirect r301 '/women/plays/16'
end
get '/plays/19' do
  redirect r301 '/women/plays/19'
end
get '/plays/21' do
  redirect r301 '/women/plays/21'
end
get '/plays/22' do
  redirect r301 '/women/plays/22'
end
get '/plays/23' do
  redirect r301 '/women/plays/23'
end
get '/plays/24' do
  redirect r301 '/women/plays/24'
end
get '/plays/25' do
  redirect r301 '/women/plays/25'
end
get '/plays/26' do
  redirect r301 '/women/plays/26'
end
get '/plays/27' do
  redirect r301 '/women/plays/27'
end
get '/plays/28' do
  redirect r301 '/women/plays/28'
end
get '/plays/29' do
  redirect r301 '/women/plays/29'
end
get '/plays/30' do
  redirect r301 '/women/plays/30'
end
get '/plays/31' do
  redirect r301 '/women/plays/31'
end
get '/plays/38' do
  redirect r301 '/women/plays/38'
end
get '/plays/32' do
  redirect r301 '/women/plays/32'
end
get '/plays/33' do
  redirect r301 '/women/plays/33'
end
get '/plays/34' do
  redirect r301 '/women/plays/34'
end
get '/plays/35' do
  redirect r301 '/women/plays/35'
end
get '/plays/36' do
  redirect r301 '/women/plays/36'
end
get '/plays/37' do
  redirect r301 '/women/plays/37'
end
get '/plays/20' do
  redirect r301 '/women/plays/20'
end

# Routes for some really old legacy URLs that still show up in analytics and webmaster tools
get '/womenindex.shtml' do
  redirect r301 '/women'
end
get '/womenindex.html' do
  redirect r301 '/women'
end
get '/womenindex.htm' do
  redirect r301 '/women'
end
get '/menindex.shtml' do
  redirect r301 '/men'
end
get '/menindex.html' do
  redirect r301 '/men'
end
get '/menindex.htm' do
  redirect r301 '/men'
end
get '/womensmonos.htm' do
  redirect r301 '/women'
end
get '/mensmonos.htm' do
  redirect r301 '/men'
end
get '/womensmonos.html' do
  redirect r301 '/women'
end
get '/mensmonos.html' do
  redirect r301 '/men'
end
get '/womensmonos.shtml' do
  redirect r301 '/women'
end
get '/mensmonos.shtml' do
  redirect r301 '/men'
end
get '/monologues/search/' do
  redirect r301 '/plays'
end