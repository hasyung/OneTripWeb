class Role < ActiveRecord::Base
  attr_accessible :name, :description, :permission_ids

  # Associations
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions

  # Validates
  validates :name, :presence => true
	 with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :description? do |description|
    description.validates :description, :length => { :within => 2..100 }
  end

  # Scopes
  scope :search_name, lambda { |name| where("ucase(`roles`.`name`) like concat('%',ucase(?),'%')", name) }

end
