Monologues::App.helpers do

  def display_limit
    return DISPLAY_LIMIT_MOBILE if is_mobile? rescue false
	DISPLAY_LIMIT
  end

  def gender_word(param)
	case param
	when 'a'
		"All"
	when 'w'
		"Women's"
	when 'm'
		"Men's"
	end
  end
end