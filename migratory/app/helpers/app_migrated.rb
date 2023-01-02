
# This file was originally written for Padrino 0.13 by
 # Brandon Faloona, then migrated to Sinatra 3.0.5 by
 # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
 # December 2022.
 #

require 'sinatra'

DISPLAY_LIMIT = 10
DISPLAY_LIMIT_MOBILE = 5

helpers do
  # Returns the display limit based on mobile or desktop
  def display_limit
    return DISPLAY_LIMIT_MOBILE if is_mobile? rescue false
    DISPLAY_LIMIT
  end

  # Returns the gender word based on the given parameter
  def gender_word(param)
    case param
    when 'a'
      nil
    when 'w'
      "Women's"
    when 'm'
      "Men's"
    end
  end

  # Returns the gender letter based on the given id
  def gender_letter(id)
    case id
    when 1, '1'
      'a'
    when 2, '2'
      'w'
    when 3, '3'
      'm'
    end
  end

  # Returns the gender path based on the given id
  def gender_path(id)
    case id
    when 1, '1'
      ''
    when 2, '2'
      '/women'
    when 3, '3'
      '/men'
    end
  end

  # Returns the gender from the path info
  def gender_from_path
    case request.path_info
    when /^\/men/, /^\/women/
      request.path_info[1]
    else
      nil
    end
  end

  # Generates a link to the specified play, based on the gender
  def gendered_play_link(play)
    case session[:gender]
    when 'a', nil, ''
      link_to(play.title, url_for(:plays, :show, id: play.id))
    when 'w'
      link_to(play.title, url_for(:plays, :showwomen, id: play.id))
    when 'm'
      link_to(play.title, url_for(:plays, :showmen, id: play.id))
    end
  end

  # Generates a javascript string to set the gParam object
  def js_set_global_params
    # defaults
    params = {gender: 'a', toggle: 'collapse', query: nil, play: 0}

    # override defaults
    play = Play.find(session[:play]) rescue nil
    play_title = play&.title || ''
    params[:gender] = session[:gender] if session[:gender]
    params[:query] = session[:query] if session[:query]
    params[:play] = play.id if play
    params[:playTitle] = play_title if play_title
    params[:toggle] = session[:toggle] if session[:toggle]

    output = "// js_set_global_params\ngParams = #{JSON.pretty_generate(params)};\ngParams['query'] = $('#search-box').val().trim();\n"
    return output
  end

  # Calls the play route based on the gender
  def do_play play_id, gender_id=nil
    if gender_id
      call(env.merge("PATH_INFO" => "#{gender_path(gender_id)}/plays/#{play_id}"))
    else
      call(env.merge("PATH_INFO" => "/plays/#{play_id}"))
    end
  end
end

# Please do not tersify these routes. Freaky caching behavior breaks things without the detailed routes that follow here
use Rack::Rewrite do
  r301 %r{^/plays/13\?g=3(\?.*)?$}, '/men/plays/13$1'
  r301 %r{^/plays/9\?g=3(\?.*)?$}, '/men/plays/9$1'
  r301 %r{^/plays/1\?g=3(\?.*)?$}, '/men/plays/1$1'
  r301 %r{^/plays/3\?g=3(\?.*)?$}, '/men/plays/3$1'
  r301 %r{^/plays/4\?g=3(\?.*)?$}, '/men/plays/4$1'
get '/plays/:id' do
  redirect "/plays/#{params[:id]}?g=#{params[:g]}"
end

# Redirects for men plays
get '/plays/:id' do
  if params[:g] == '3'
    redirect "/men/plays/#{params[:id]}"
  end
end

# Redirects for women plays
get '/plays/:id' do
  if params[:g] == '2'
    redirect "/women/plays/#{params[:id]}"
  end
end# Redirects for Padrino 0.13 URLs
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