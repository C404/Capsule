class Account
  SERVICES = ['facebook', 'twitter', 'dailymotion', 'youtube']
  include Mongoid::Document
  field :username, type: String
  field :password, type: String
  has_many :sessions, dependent: :delete
  #validates :username, :uniqueness: true
  #validates :username, :password, presence: true
end
