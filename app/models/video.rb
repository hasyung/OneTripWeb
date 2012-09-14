class Video < ActiveRecord::Base
  attr_accessible :name, :place_id, :category_cd, :duration, :attachment, :cover, :order

  # Associations
  belongs_to :place, :counter_cache => true

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
    attachment.validates :attachment, :file_size => { :maximum => 20.megabytes.to_i }
  end
  
  with_options :if => :cover? do |cover|
    cover.validates :cover, :file_size => { :maximum => 5.megabytes.to_i }
  end

  # Carrierwave
  mount_uploader :attachment, AudioUploader

  # Scopes
  scope :order_desc, order("`order` DESC")

end
