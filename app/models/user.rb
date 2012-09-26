class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids
  
	# Associations
	has_and_belongs_to_many :roles

  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Scopes
  scope :search_name, lambda { |name| where("ucase(`users`.`email`) like concat('%',ucase(?),'%')", name) }
  scope :newest, lambda { |count| where(:admin => false).limit(count) }
  scope :created_desc, order("created_at DESC")
  scope :order_desc, order("`order` DESC")

  # Methods
  def permissions
  	permissions = []
  	if roles.any?
  		self.roles.each { |role| permissions.concat(role.permissions) }
  	end
  	permissions.uniq
  end
end
