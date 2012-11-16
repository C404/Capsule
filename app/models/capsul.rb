class Capsul < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  acts_as_gmappable :process_geocoding => false
  attr_accessible :description, :video, :longitude, :latitude
end
