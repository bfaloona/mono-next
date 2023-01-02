
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

require 'sinatra'
require 'active_record'

# Defines an Author class that inherits from ActiveRecord::Base
class Author < ActiveRecord::Base
  # Establishes a one-to-many relationship between Author and Plays
  has_many :plays

  # Validates that the name of an Author is present
  validates_presence_of :name
  # Validates that the name of an Author is unique
  validates_uniqueness_of :name
end