class Comment < ActiveRecord::Base
  belongs_to :capsul
  attr_accessible :content, :user_id
end
