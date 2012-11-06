class UserToken < ActiveRecord::Base
  belongs_to :user
  attr_accessible :da_token, :fb_token, :tw_token
end
