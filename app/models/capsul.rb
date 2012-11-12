class Capsul < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :video, :longitude, :latitude
end
