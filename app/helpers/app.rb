Monologues::App.helpers do

  def display_limit
    return DISPLAY_LIMIT_MOBILE if is_mobile? rescue false
	DISPLAY_LIMIT
  end

  def gender_word(param)
	case param
	when 'a'
	  ""
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

end