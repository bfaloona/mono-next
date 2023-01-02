
#
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#

# Monologue class inherits from ActiveRecord::Base and contains methods for validating, searching, and retrieving Monologue objects
class Monologue < ActiveRecord::Base
  # Associations
  belongs_to :gender
  belongs_to :author
  belongs_to :play

  # Validations
  validates :play_id, presence: true
  validates :first_line, presence: true, uniqueness: { scope: :play_id }
  validates :location, length: { maximum: 20 }, allow_nil: true
  validates :first_line, length: { maximum: 255 }
  validates :character, length: { maximum: 80 }, allow_nil: true
  validates :style, length: { maximum: 20 }, allow_nil: true
  validates :body_link, length: { maximum: 255 }, allow_nil: true
  validates :pdf_link, length: { maximum: 255 }, allow_nil: true

  # Class method for filtering Monologues by gender
  def self.gender(gender_param=nil)
    case gender_param
    when nil, '', 'a', 1, '1'
      all
    when 'w', 2, '2'
      where("gender_id = ? OR gender_id = ?", 2, 1)
    when 'm', 3, '3'
      where("gender_id = ? OR gender_id = ?", 3, 1)
    else
      all
    end
  end

  # Class method for searching Monologues by a given term
  def self.matching(term)
    t = "%#{term.to_s.strip.downcase}%"
    where( 'first_line ILIKE ? OR
              character ILIKE ? OR
              body ILIKE ? OR
              location ILIKE ?',
              t, t, t, t)
  end

  # Instance method for returning the intercut label
  def intercut_label
    self.intercut == 1 ? '- intercut' : ''
  end
end