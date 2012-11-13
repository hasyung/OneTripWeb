class Image < ActiveRecord::Base
  attr_accessible :name, :image, :area_id, :order

   # Associations
  belongs_to :area, :include => :area_category
  
  # Callbacks
  before_save :update_image_attributes

  # carrierwave
  mount_uploader :image, MapUploader

  # Validates
  validates :image, :area_id, :presence => true
  with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
  end
  with_options :if => :order? do |order|
    order.validates :order, :numericality => 
      { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999 }
  end
  with_options :if => :image? do |image|
    image.validates :image, :file_size => { :maximum => 5.megabytes.to_i }
  end

  # scopes
  scope :order_asc, order("`order` ASC")
  scope :created_desc, order("created_at DESC")
  scope :newest, lambda { |count| limit(count).includes(:area) }

  # Methods
  def update_image_attributes
  	Rails.logger.debug image.file.basename
    if image.present? && image_changed?
      self.name = image.file.basename
      self.image_size = image.file.size
      self.image_content_type = image.file.content_type
    end
  end

  def to_jq_upload
    {
      "id" => read_attribute(:id),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb_small.url
    }
  end

end
