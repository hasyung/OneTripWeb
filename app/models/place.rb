class Place < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  attr_accessible :name, :key, :keywords, :description, :map, :order, :province_id

  # Associations
  belongs_to :province, :counter_cache => true
  has_many :infos, :dependent => :destroy
  has_many :audios, :dependent => :destroy

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
  validates_attachment :map, 
    :size => { :in => 0..5.megabytes.to_i },
    :content_type => { :content_type => %w(image/jpg image/png image/jpeg image/pjpeg image/gif) }

  # Scopes
  scope :created_desc, order("created_at DESC")

  # Paperclips
  has_attached_file :map,
    :styles => {
      :thumb => "250x141",
      :small => "400>",
      :normal => "600>" },
    :default_style => :normal,
    :url => "#{APP_CONFIG["upload_url"]}/:class/:attachment/:hashed_path/:id/:style_:hash_name.:extension",
    :path => "#{APP_CONFIG["upload_path"]}/:class/:attachment/:hashed_path/:id/:style_:hash_name.:extension",
    :default_url => "default/:class/:style.jpg",
    :whiny => false

  # Methods
  def to_jq_upload
    {
      "id" => read_attribute(:id),
      "name" => read_attribute(:name),
      "size" => read_attribute(:map_file_size),
      "thumbnail_url" => map.url(:thumb),
      "edit_map_path" => edit_map_admin_place_path(:id => id),
      "place_path" => admin_place_path(:id => id)
    }
  end

end
