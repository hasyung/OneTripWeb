class Info < ActiveRecord::Base
  attr_accessible :place_id, :var, :value, :order

  # Associations
  belongs_to :place, :counter_cache => true

  # Validates
  validates :var, :value, :place_id, :presence => true
  with_options :if => :var? do |var|
    var.validates :var, :length => { :within => 2..30 }
    var.validates :var, :uniqueness => { :scope => :place_id }
  end
  with_options :if => :value? do |value|
    value.validates :value, :length => { :within => 2..1000 }
  end
  with_options :if => :order? do |order|
  	order.validates :order, :numericality => 
  		{ :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999 }
  end

  # Scopes
  scope :created_desc, order("created_at DESC")
  scope :order_desc, order("`order` DESC")
  scope :newest, lambda { |count| limit(count).includes(:place) }

end
