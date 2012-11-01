class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :capsules, :active
  # attr_accessible :title, :body


  has_many :capsuls



  validates :email, presence: true, uniqueness: true
  # validates :username, presence: true, uniqueness: true
  # validates :gender, presence: true
  # validates :location, presence: true

end
