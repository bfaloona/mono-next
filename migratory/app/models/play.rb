class Play < ActiveRecord::Base
  belongs_to :author
  has_many :monologues
  validates_presence_of :title
  validates_presence_of :author_id
  validates_uniqueness_of :title
  validates_presence_of :classification
  validates_inclusion_of :classification, :in => ['Comedy', 'History', 'Tragedy'], :allow_nil => true
end
