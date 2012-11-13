class Area < ActiveRecord::Base
  attr_accessible :areable_id, :areable_type, :area_category_id, :order

  # Associations
  belongs_to :areable, :polymorphic => true
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

  # Scopes
  scope :created_desc, order("created_at DESC")
  scope :order_asc, order("`order` ASC")

end
