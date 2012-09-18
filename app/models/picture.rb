class Picture < ActiveRecord::Base
  attr_accessible :name, :image

  # Callbacks
  before_save :update_image_attributes

  # carrierwave
  mount_uploader :image, ImageUploader

  # Validates
  validates :image, :presence => true
  with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
  end

  # scopes
  scope :created_desc, order("created_at DESC")

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
