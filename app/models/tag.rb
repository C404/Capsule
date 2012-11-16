class Tag < ActiveRecord::Base
  attr_accessible :tag

  has_and_belongs_to_many :capsuls

  validates_uniqueness_of :tag
  validates :tag, :uniqueness => true
end
