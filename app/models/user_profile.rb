class UserProfile < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :real_name, :sex_cd, :position, :user_id

	# Associations
  belongs_to :user

  # enums
  as_enum :sex, {:male => 0,  :female => 1}
  
  # Validates
  validates :real_name, :sex_cd, :presence => true
	 with_options :if => :real_name? do |real_name|
    real_name.validates :real_name, :length => { :within => 2..30 }
  end
  
end
