Monologues::App.helpers do

  def display_limit
    return DISPLAY_LIMIT_MOBILE if is_mobile? rescue false
    DISPLAY_LIMIT
  end

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

  def gender_from_path
    case request.path_info
    when /^\/men/, /^\/women/
      request.path_info[1]
    else
      nil
    end
  end

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

  def js_set_global_params
    # return javascript string to set gParam object

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

  def do_play play_id, gender_id=nil
    if gender_id
      call(env.merge("PATH_INFO" => "#{gender_path(gender_id)}/plays/#{play_id}"))
    else
      call(env.merge("PATH_INFO" => "/plays/#{play_id}"))
    end
  end
  # Please do not tersify these routes. Freaky caching behavior breaks things without the detailed routes that follow here
  use Rack::Rewrite do
    r301 %r{^/plays/13\?g=3(\?.*)?$}, '/men/plays/13$1'
    r301 %r{^/plays/9\?g=3(\?.*)?$}, '/men/plays/9$1'
    r301 %r{^/plays/1\?g=3(\?.*)?$}, '/men/plays/1$1'
    r301 %r{^/plays/3\?g=3(\?.*)?$}, '/men/plays/3$1'
    r301 %r{^/plays/4\?g=3(\?.*)?$}, '/men/plays/4$1'
    r301 %r{^/plays/10\?g=3(\?.*)?$}, '/men/plays/10$1'
    r301 %r{^/plays/11\?g=3(\?.*)?$}, '/men/plays/11$1'
    r301 %r{^/plays/6\?g=3(\?.*)?$}, '/men/plays/6$1'
    r301 %r{^/plays/18\?g=3(\?.*)?$}, '/men/plays/18$1'
    r301 %r{^/plays/2\?g=3(\?.*)?$}, '/men/plays/2$1'
    r301 %r{^/plays/5\?g=3(\?.*)?$}, '/men/plays/5$1'
    r301 %r{^/plays/7\?g=3(\?.*)?$}, '/men/plays/7$1'
    r301 %r{^/plays/14\?g=3(\?.*)?$}, '/men/plays/14$1'
    r301 %r{^/plays/17\?g=3(\?.*)?$}, '/men/plays/17$1'
    r301 %r{^/plays/15\?g=3(\?.*)?$}, '/men/plays/15$1'
    r301 %r{^/plays/8\?g=3(\?.*)?$}, '/men/plays/8$1'
    r301 %r{^/plays/16\?g=3(\?.*)?$}, '/men/plays/16$1'
    r301 %r{^/plays/19\?g=3(\?.*)?$}, '/men/plays/19$1'
    r301 %r{^/plays/20\?g=3(\?.*)?$}, '/men/plays/20$1'
    r301 %r{^/plays/21\?g=3(\?.*)?$}, '/men/plays/21$1'
    r301 %r{^/plays/22\?g=3(\?.*)?$}, '/men/plays/22$1'
    r301 %r{^/plays/23\?g=3(\?.*)?$}, '/men/plays/23$1'
    r301 %r{^/plays/24\?g=3(\?.*)?$}, '/men/plays/24$1'
    r301 %r{^/plays/25\?g=3(\?.*)?$}, '/men/plays/25$1'
    r301 %r{^/plays/26\?g=3(\?.*)?$}, '/men/plays/26$1'
    r301 %r{^/plays/27\?g=3(\?.*)?$}, '/men/plays/27$1'
    r301 %r{^/plays/28\?g=3(\?.*)?$}, '/men/plays/28$1'
    r301 %r{^/plays/29\?g=3(\?.*)?$}, '/men/plays/29$1'
    r301 %r{^/plays/30\?g=3(\?.*)?$}, '/men/plays/30$1'
    r301 %r{^/plays/31\?g=3(\?.*)?$}, '/men/plays/31$1'
    r301 %r{^/plays/38\?g=3(\?.*)?$}, '/men/plays/38$1'
    r301 %r{^/plays/32\?g=3(\?.*)?$}, '/men/plays/32$1'
    r301 %r{^/plays/33\?g=3(\?.*)?$}, '/men/plays/33$1'
    r301 %r{^/plays/34\?g=3(\?.*)?$}, '/men/plays/34$1'
    r301 %r{^/plays/35\?g=3(\?.*)?$}, '/men/plays/35$1'
    r301 %r{^/plays/36\?g=3(\?.*)?$}, '/men/plays/36$1'
    r301 %r{^/plays/37\?g=3(\?.*)?$}, '/men/plays/37$1'
    r301 %r{^/plays/13\?g=2(\?.*)?$}, '/women/plays/13$1'
    r301 %r{^/plays/9\?g=2(\?.*)?$}, '/women/plays/9$1'
    r301 %r{^/plays/1\?g=2(\?.*)?$}, '/women/plays/1$1'
    r301 %r{^/plays/3\?g=2(\?.*)?$}, '/women/plays/3$1'
    r301 %r{^/plays/4\?g=2(\?.*)?$}, '/women/plays/4$1'
    r301 %r{^/plays/10\?g=2(\?.*)?$}, '/women/plays/10$1'
    r301 %r{^/plays/11\?g=2(\?.*)?$}, '/women/plays/11$1'
    r301 %r{^/plays/6\?g=2(\?.*)?$}, '/women/plays/6$1'
    r301 %r{^/plays/18\?g=2(\?.*)?$}, '/women/plays/18$1'
    r301 %r{^/plays/2\?g=2(\?.*)?$}, '/women/plays/2$1'
    r301 %r{^/plays/5\?g=2(\?.*)?$}, '/women/plays/5$1'
    r301 %r{^/plays/7\?g=2(\?.*)?$}, '/women/plays/7$1'
    r301 %r{^/plays/14\?g=2(\?.*)?$}, '/women/plays/14$1'
    r301 %r{^/plays/17\?g=2(\?.*)?$}, '/women/plays/17$1'
    r301 %r{^/plays/15\?g=2(\?.*)?$}, '/women/plays/15$1'
    r301 %r{^/plays/8\?g=2(\?.*)?$}, '/women/plays/8$1'
    r301 %r{^/plays/16\?g=2(\?.*)?$}, '/women/plays/16$1'
    r301 %r{^/plays/19\?g=2(\?.*)?$}, '/women/plays/19$1'
    r301 %r{^/plays/21\?g=2(\?.*)?$}, '/women/plays/21$1'
    r301 %r{^/plays/22\?g=2(\?.*)?$}, '/women/plays/22$1'
    r301 %r{^/plays/23\?g=2(\?.*)?$}, '/women/plays/23$1'
    r301 %r{^/plays/24\?g=2(\?.*)?$}, '/women/plays/24$1'
    r301 %r{^/plays/25\?g=2(\?.*)?$}, '/women/plays/25$1'
    r301 %r{^/plays/26\?g=2(\?.*)?$}, '/women/plays/26$1'
    r301 %r{^/plays/27\?g=2(\?.*)?$}, '/women/plays/27$1'
    r301 %r{^/plays/28\?g=2(\?.*)?$}, '/women/plays/28$1'
    r301 %r{^/plays/29\?g=2(\?.*)?$}, '/women/plays/29$1'
    r301 %r{^/plays/30\?g=2(\?.*)?$}, '/women/plays/30$1'
    r301 %r{^/plays/31\?g=2(\?.*)?$}, '/women/plays/31$1'
    r301 %r{^/plays/38\?g=2(\?.*)?$}, '/women/plays/38$1'
    r301 %r{^/plays/32\?g=2(\?.*)?$}, '/women/plays/32$1'
    r301 %r{^/plays/33\?g=2(\?.*)?$}, '/women/plays/33$1'
    r301 %r{^/plays/34\?g=2(\?.*)?$}, '/women/plays/34$1'
    r301 %r{^/plays/35\?g=2(\?.*)?$}, '/women/plays/35$1'
    r301 %r{^/plays/36\?g=2(\?.*)?$}, '/women/plays/36$1'
    r301 %r{^/plays/37\?g=2(\?.*)?$}, '/women/plays/37$1'
    r301 %r{^/plays/20\?g=2(\?.*)?$}, '/women/plays/20$1'

    # Routes for some really old legacy URLs that still show up in analytics and webmaster tools

    r301 %r{^/womenindex.shtml(\?.*)?$}, '/women$1'
    r301 %r{^/womenindex.html(\?.*)?$}, '/women$1'
    r301 %r{^/womenindex.htm(\?.*)?$}, '/women$1'
    r301 %r{^/menindex.shtml(\?.*)?$}, '/men$1'
    r301 %r{^/menindex.html(\?.*)?$}, '/men$1'
    r301 %r{^/menindex.htm(\?.*)?$}, '/men$1'
    r301 %r{^/womensmonos.htm(\?.*)?$}, '/women$1'
    r301 %r{^/mensmonos.htm(\?.*)?$}, '/men$1'
    r301 %r{^/womensmonos.html(\?.*)?$}, '/women$1'
    r301 %r{^/mensmonos.html(\?.*)?$}, '/men$1'
    r301 %r{^/womensmonos.shtml(\?.*)?$}, '/women$1'
    r301 %r{^/mensmonos.shtml(\?.*)?$}, '/men$1'    
    r301 %r{^/monologues/search/?(\?.*)?$}, '/plays$1'

  end
end
