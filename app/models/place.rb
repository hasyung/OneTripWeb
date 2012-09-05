class Place < ActiveRecord::Base
  attr_accessible :name, :key, :keywords, :description, :map, :order, :province_id, :map_cache

  # Associations
  belongs_to :province, :counter_cache => true

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
    map.validates :map, :file_size => { :maximum => 5.megabytes.to_i }
  end

  # scopes
  scope :created_desc, order("created_at DESC")

  # carrierwave
  mount_uploader :map, MapUploader

  # Callbacks
  before_save :update_image_attributes

  # Methods
  def update_image_attributes
    if map.present? && map_changed?
      self.map_name = map.file.basename
      self.map_size = map.file.size
      self.map_content_type = map.file.content_type
    end
  end

end
