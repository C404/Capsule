##
## capsule.rb
## Login : <lta@still>
## Started on  Sat Nov 17 20:29:05 2012 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2012 Lta Akr
##

class Capsule
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  
  #field :user_id
  #belongs_to :user

  field :content, type: String
  field :hashtags, type:  Array
  field :location, type: Array

  # CarrierWave
  field :video, type: String
  mount_uploader :video, CapsuleUploader

  index location: "2d"
  index hashtags: 1

  before_save do
    self.hashtags = self.content.scan /#\w+/
  end
end

