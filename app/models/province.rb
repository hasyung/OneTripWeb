class Province < ActiveRecord::Base
  include FriendlyId
  
  attr_accessible :name, :key

  # Associations
  has_many :places, :order => "created_at DESC"
  has_many :minorities, :order => "created_at_DESC"
  
  # FriendlyId
  friendly_id :key, :use => :slugged

  # Validates
  validates :name, :key, :presence => true

  with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :key? do |key|
    key.validates :key, :uniqueness => true
    key.validates :key, :format => { :with => /^[a-z0-9\-]*$/ }
    key.validates :key, :length => { :within => 2..10 }
  end

  # Scopes
  scope :created_desc, order("created_at DESC")
  scope :search_name, lambda { |name| where("ucase(`provinces`.`name`) like concat('%',ucase(?),'%')", name) }

end
