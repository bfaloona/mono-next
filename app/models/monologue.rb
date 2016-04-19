class Monologue < ActiveRecord::Base
  belongs_to :gender
  belongs_to :author
  belongs_to :play

  validates_presence_of :play_id
  validates_presence_of :first_line
  validates_uniqueness_of :first_line, :scope => :play_id


  validates_length_of :location, :maximum=>20, :allow_nil => true
  validates_length_of :first_line, :maximum=>255
  validates_length_of :character, :maximum=>80, :allow_nil => true
  validates_length_of :style, :maximum=>20, :allow_nil => true
  validates_length_of :body_link, :maximum=>255, :allow_nil => true
  validates_length_of :pdf_link, :maximum=>255, :allow_nil => true

  def self.gender(gender_param=nil)

    # TODO Gender state is too complicated!
    # 'Both' and All should be the same case, but it's not.
    case gender_param
    when nil, 'a'
      all
    when 'w'
      where("gender_id = ? OR gender_id = ?", 2, 1)
    when 'm'
      where("gender_id = ? OR gender_id = ?", 3, 1)
    else
      raise ArgumentError, "Cannot parse gender_parameter: #{gender_param}"
    end
  end

  def self.matching(term)
    t = "%#{term.to_s.strip.downcase}%"
    where( 'first_line ILIKE ? OR
              character ILIKE ? OR
              body ILIKE ? OR
              location ILIKE ?',
              t, t, t, t)
  end

  def intercut_label
    self.intercut == 1 ? '- intercut' : ''
  end

end
