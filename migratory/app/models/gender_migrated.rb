
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

require 'sinatra'
require 'sinatra/activerecord'

# Defines the Gender class with ActiveRecord
class Gender < ActiveRecord::Base
  # Establishes the one-to-many relationship between Gender and Monologues
  has_many :monologues

  # Validates the presence of the 'name' attribute
  validates_presence_of :name

  # Validates the uniqueness of the 'name' attribute
  validates_uniqueness_of :name
end