
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