class Area < ActiveRecord::Base
  attr_accessible :areable_id, :areable_type, :area_category_id, :order, :description

  # Associations
  belongs_to :areable, :polymorphic => true, :counter_cache => true
  belongs_to :area_category
  has_many :videos, :dependent => :destroy
  has_many :audios, :dependent => :destroy
  has_many :infos, :dependent => :destroy
  has_many :articles, :dependent => :destroy
  has_many :images, :dependent => :destroy

  #SimpleEnum
  as_enum :status, { :draft => 0, :publish => 1 }

  # Validates
  validates :areable_id, :areable_type, :area_category_id, :presence => true
  with_options :if => :order? do |order|
    order.validates :order, :numericality => 
      { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999 }
  end
  with_options :if => :description? do |description|
  	description.validates :description, :length => { :within => 2..1000 }
  end
  with_options :if => :area_category_id? do |area_category_id|
  	area_category_id.validates :area_category_id, :uniqueness => { :scope => [:areable_type, :areable_id] }
  end

  # Scopes
  scope :created_desc, order("created_at DESC")
  scope :order_asc, order("`order` ASC")

end
