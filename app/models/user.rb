class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
  			 :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable

  attr_accessible :first_name, 
                  :last_name, 
                  :email, 
                  :password, 
                  :instrument,
                  :state,
                  :city,
                  :street

  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :instrument,  presence: true
end
