class Special < ActiveRecord::Base
  attr_accessible :name, :key, :keywords, :description, :order
  
  # Associations
  belongs_to :category, :counter_cache => true
  belongs_to :province, :counter_cache => true
  
  # Validates
  validates :name, :key, :slug, :province_id, :category_id, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :key? do |key|
  	key.validates :key, :uniqueness => true
  	key.validates :key, :format => { :with => /^[a-z0-9\-]*$/ }
  	key.validates :key, :length => { :within => 2..30 }
  end
  with_options :if => :keywords? do |keywords|
    keywords.validates :keywords, :length => { :within => 2..100 }
  end
  with_options :if => :description? do |description|
    description.validates :description, :length => { :within => 2..100 }
  end
  with_options :if => :order? do |order|
    order.validates :order, :numericality => 
      { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999 }
  end
end
