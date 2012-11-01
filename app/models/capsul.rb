class Capsul < ActiveRecord::Base
  attr_accessible :content, :user_id, :video
  belongs_to :user
  has_many :comments
end
