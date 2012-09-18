class Article < ActiveRecord::Base
	attr_accessible :title, :place_id, :category_cd, :keywords, :description, :author, :body, :order

  # Associations
  belongs_to :place, :counter_cache => true

  #SimpleEnum
  as_enum :category, { :travels => 0, :recommend => 1 }

  # Validates
  validates :title, :place_id, :category_cd, :author, :body, :presence => true
	with_options :if => :title? do |title|
    title.validates :title, :length => { :within => 2..200 }
    title.validates :title, :uniqueness => { :scope => :place_id }
  end
  with_options :if => :order? do |order|
    order.validates :order, :numericality => 
      { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999 }
  end
  with_options :if => :keywords? do |keywords|
  	keywords.validates :keywords, :length => { :within => 2..100 }
  end
  with_options :if => :description? do |description|
  	description.validates :description, :length => { :within => 2..100 }
  end
  with_options :if => :author? do |author|
  	author.validates :author, :length => { :within => 2..50 }
  end

  # Scopes
  scope :created_desc, order("created_at DESC")
  scope :order_desc, order("`order` DESC")
  scope :all_travels, where(:category_cd => Article.travels)
  scope :recommends, where(:category_cd => Article.recommend)
end
