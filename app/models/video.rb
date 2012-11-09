class Video < ActiveRecord::Base
  attr_accessible :area_id, :duration, :attachment, :cover, :order, :cover_cache

  # Associations
  belongs_to :area, :include => :area_category

  # Callbacks
  before_save :update_video_attributes, :update_video_cover_attributes
  
  # Validates
  validates :area_id, :attachment, :cover, :duration, :presence => true
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
  scope :order_desc, order("`order` DESC")
  scope :created_desc, order("created_at DESC")
  scope :newest, lambda { |count| limit(count).includes(:area) }
  
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
