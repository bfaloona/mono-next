class Gender < ActiveRecord::Base
  has_many :monologues
  validates_presence_of :name
  validates_uniqueness_of :name
end
