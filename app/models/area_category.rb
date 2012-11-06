class AreaCategory < ActiveRecord::Base
	attr_accessible :name, :description, :style_type

  # Associations
  belongs_to :area
  
  #SimpleEnum
  as_enum :style_type, { :style_0 => 0, :style_1 => 1, :style_2 => 2, :style_3 => 3, :style_4 => 4 }

  # Validates
  validates :name, :style_type, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..100 }
    name.validates :name, :uniqueness => { :scope => :place_id }
  end
  with_options :if => :description? do |description|
  	description.validates :description, :length => { :within => 2..100 }
  end
  
  # Scopes
  scope :created_desc, order("created_at DESC")
end
