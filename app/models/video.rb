class Video < ActiveRecord::Base
  attr_accessible :name, :place_id, :category_cd, :duration, :attachment, :cover, :order

  # Associations
  belongs_to :place, :counter_cache => true

  # Callbacks
  before_save :update_video_attributes, :update_video_cover_attributes
  
   #SimpleEnum
  as_enum :category, { :impression => 0, :route => 1 }
  
  # Validates
  validates :name, :place_id, :category_cd, :attachment, :duration, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :order? do |order|
    order.validates :order, :numericality => 
      { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999 }
  end
  with_options :if => :duration do |duration|
    duration.validates :duration, :format => { :with => /(?:[01]\d|2[0-3])(?::[0-5]\d){2}$/, 
      :message => I18n.translate("errors.messages.format_invalid") }
  end
  with_options :if => :attachment? do |attachment|
    attachment.validates :attachment, :file_size => { :maximum => 100.megabytes.to_i }
  end
  
  with_options :if => :cover? do |cover|
    cover.validates :cover, :file_size => { :maximum => 10.megabytes.to_i }
  end

  # Carrierwave
  mount_uploader :attachment, VideoUploader
  mount_uploader :cover, VideoCoverUploader

  # Scopes
  scope :impressions, where(:category_cd => :impression).order("`order` DESC")
  scope :routes, where(:category_cd => :route).order("`order` DESC")
  scope :order_desc, order("`order` DESC")
  
  def update_video_attributes
    if attachment.present? && attachment_changed?
      self.attachment_size = attachment.file.size
      self.attachment_content_type = attachment.file.content_type
    end
  end
  
  def update_video_cover_attributes
    if cover.present? && cover_changed?
      self.cover_size = cover.file.size
      self.cover_content_type = cover.file.content_type
    end
  end

end
