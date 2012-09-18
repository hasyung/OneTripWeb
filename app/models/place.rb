class Place < ActiveRecord::Base
  attr_accessible :name, :key, :keywords, :description, :map, :order, :province_id, :map_cache

  # Callbacks
  before_save :update_map_attributes

  # Associations
  belongs_to :province, :counter_cache => true
  has_many :infos, :dependent => :destroy
  has_many :audios, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_many :articles, :dependent => :destroy


  # Validates
  validates :name, :key, :province_id, :map, :presence => true
	 with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :key? do |key|
  	key.validates :key, :uniqueness => true
  	key.validates :key, :format => { :with => /^[A-Za-z0-9\s]+$/ }
  	key.validates :key, :length => { :within => 2..30 }
  end
  with_options :if => :map? do |map|
    map.validates :map, :file_size => { :maximum => 10.megabytes.to_i }
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

  # Carrierwave
  mount_uploader :map, MapUploader
  
  # Methods
  def update_map_attributes
    if map.present? && map_changed?
      self.map_size = map.file.size
      self.map_content_type = map.file.content_type
    end
  end

end
