class Audio < ActiveRecord::Base
  attr_accessible :name, :place_id, :category_cd, :duration, :attachment, :order

  # Associations
  belongs_to :place, :counter_cache => true

  # Callbacks
  before_save :update_audio_attributes
  
  #SimpleEnum
  as_enum :category, { :narrate => 0, :story => 1 }

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
    attachment.validates :attachment, :file_size => { :maximum => 10.megabytes.to_i }
  end

  # Carrierwave
  mount_uploader :attachment, AudioUploader

  # Scopes
  scope :created_desc, order("created_at DESC")
  scope :order_desc, order("`order` DESC")
  scope :narrates, where(:category_cd => Audio.narrate)
  scope :newest, lambda { |count| limit(count).includes(:place) }

  def update_audio_attributes
    if attachment.present? && attachment_changed?
      self.attachment_size = attachment.file.size
      self.attachment_content_type = attachment.file.content_type
    end
  end
end
