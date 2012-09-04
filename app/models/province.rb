class Province < ActiveRecord::Base
  attr_accessible :name, :key

  # Associations
  has_many :places, :order => "created_at DESC"

  # Validates
  validates :name, :key, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :key? do |key|
  	key.validates :key, :uniqueness => true
  	key.validates :key, :format => { :with => /^[A-Za-z0-9\s]+$/ }
  	key.validates :key, :length => { :within => 2..30 }
  end

  # Scopes
  scope :search_name, lambda { |name| where("ucase(`provinces`.`name`) like concat('%',ucase(?),'%')", name) }

end
