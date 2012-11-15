class Capsul < ActiveRecord::Base
  belongs_to :user
  acts_as_gmappable :process_geocoding => false
  attr_accessible :description, :video, :longitude, :latitude
end
