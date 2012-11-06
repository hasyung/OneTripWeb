class Place < ActiveRecord::Base
  include FriendlyId
  attr_accessible :name, :key, :keywords, :description, :order, :province_id

  # Associations
  belongs_to :province, :counter_cache => true
  has_many :areas, :as => :areable, :dependent => :destroy

  # FriendlyId
  friendly_id :key, :use => :slugged
  
  #SimpleEnum
  as_enum :status, { :draft => 0, :publish => 1 }

  # Validates
  validates :name, :key, :province_id, :presence => true
	 with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :key? do |key|
  	key.validates :key, :uniqueness => true
  	key.validates :key, :format => { :with => /^[A-Za-z0-9\s]+$/ }
  	key.validates :key, :length => { :within => 2..30 }
  end
  with_options :if => :keywords? do |keywords|
    keywords.validates :keywords, :length => { :within => 2..100 }
  end
  with_options :if => :description? do |description|
    description.validates :description, :length => { :within => 2..1000 }
  end
  with_options :if => :order? do |order|
    order.validates :order, :numericality => 
      { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999 }
  end

  # Scopes
  scope :created_desc, order("created_at DESC")
  scope :search_name, lambda { |name| where("ucase(`places`.`name`) like concat('%',ucase(?),'%')", name) }
  scope :newest, lambda { |count| limit(count) }

end
