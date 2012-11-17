class UserToken < ActiveRecord::Base
  belongs_to :user
  attr_accessible :da_token, :da_email, :fb_token, :fb_email, :fb_username, :tw_token, :tw_username
end
