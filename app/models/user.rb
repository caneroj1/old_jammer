class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
  			 :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable

  # a user has many messages. these are NOT messages that they send
  # they are messages sent to THEM
  has_and_belongs_to_many :messages

  attr_accessible :first_name, 
                  :last_name, 
                  :email, 
                  :password, 
                  :instrument,
                  :state,
                  :city,
                  :street,
                  :lessons

  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :instrument,  presence: true

  mount_uploader :avatar, AvatarUploader

  # this will return an output string that will be used
  # to indicate if the musician gives lessons
  def lessons?
    lessons ? 
    ["#{first_name} is interested in giving lessons.", "yes-lessons"] : 
    ["#{first_name} is not interested in giving lessons at this time.", "no-lessons"]
  end
end
