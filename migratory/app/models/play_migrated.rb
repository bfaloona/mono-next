
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

require 'sinatra'
require 'active_record'

class Play < ActiveRecord::Base
  # Establishes the relationship between the Play and Author models
  belongs_to :author
  
  # Establishes the relationship between the Play and Monologue models
  has_many :monologues
  
  # Validates that the Play has a title
  validates :title, presence: true
  
  # Validates that the Play has an author_id
  validates :author_id, presence: true
  
  # Validates that the Play title is unique
  validates :title, uniqueness: true
  
  # Validates that the Play classification is one of the specified options
  validates :classification, inclusion: { in: ["Comedy", "History", "Tragedy"], allow_nil: true }
end