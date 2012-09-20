class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
