class Session
  include Mongoid::Document
  field :token, type: String
  belongs_to :user
end
