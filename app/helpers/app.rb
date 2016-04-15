Monologues::App.helpers do

  def display_limit
    return DISPLAY_LIMIT_MOBILE if is_mobile? rescue false
	DISPLAY_LIMIT
  end

  def gender_word(param)
	case param
	when 'a', '', '1', 1
		"All"
	when 'w', '2', 2
		"Women's"
	when 'm', '3', 3
		"Men's"
	end
  end
end