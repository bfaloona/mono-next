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

  def gender_from_path
    case request.path_info[1]
    when 'p'
      # treat /plays route as all, but return nil
      nil
    else
      request.path_info[1]
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
    params = {gender: 'a', toggle: 'collapse', query: nil, play: 0, placeholder: "Search Shakespeare's Monologues"}
    play = Play.find(session[:play]) rescue nil
    play_title = play&.title || ''
    params[:gender] = session[:gender] if session[:gender]
    params[:query] = session[:query] if session[:query]
    params[:play] = play.id if play
    params[:playTitle] = play_title if play_title
    params[:toggle] = session[:toggle] if session[:toggle]
    params[:placeholder] = searchbox_placeholder_text

    output = "gParams = #{JSON.pretty_generate(params)};\ngParams['query'] = $('#search-box').val().trim();\n"
    return output
  end

  def searchbox_placeholder_text
    [ "Search",
      "Shakespeare's",
      @play&.title,
      gender_word(session[:gender]),
      "Monologues"
    ].compact.join(' ')
  end

end