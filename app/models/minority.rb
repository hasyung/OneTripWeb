class Minority < ActiveRecord::Base
  include FriendlyId
  attr_accessible :name, :key, :keywords, :description, :order, :province_id, :subtitle, :image_title

  # Associations
  belongs_to :province, :counter_cache => true
  has_many :areas, :as => :areable, :dependent => :destroy

   # Carrierwave
  mount_uploader :image_title, MinorityTitleUploader
  
  # Callbacks
  before_save :update_image_title_attributes
  
  # FriendlyId
  friendly_id :key, :use => :slugged
  
  #SimpleEnum
  as_enum :status, { :draft => 0, :publish => 1 }

  # Validates
  validates :name, :key, :province_id, :image_title, :presence => true
	 with_options :if => :name? do |name|
    name.validates :name, :format => { :with => /^[\u2E80-\uFE4F]+$/ }
    name.validates :name, :length => { :within => 2..30 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :key? do |key|
  	key.validates :key, :uniqueness => true
  	key.validates :key, :format => { :with => /^[A-Za-z0-9\s]+$/ }
  	key.validates :key, :length => { :within => 2..30 }
  end
  with_options :if => :keywords? do |keywords|
    keywords.validates :keywords, :length => { :within => 2..100 }
  end
  with_options :if => :description? do |description|
    description.validates :description, :length => { :within => 2..1000 }
  end
  with_options :if => :subtitle? do |subtitle|
    subtitle.validates :subtitle, :length => { :within => 2..12 }
  end
  with_options :if => :order? do |order|
    order.validates :order, :numericality => 
      { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999 }
  end
  with_options :if => :image_title? do |image_title|
    image_title.validates :image_title, :file_size => { :maximum => 1.megabytes.to_i }
  end

  # Scopes
  scope :created_desc, order("created_at DESC")
  scope :order_asc, order("`order` ASC")
  scope :search_name, lambda { |name| where("ucase(`minorities`.`name`) like concat('%',ucase(?),'%')", name) }
  scope :newest, lambda { |count| limit(count) }

  def update_image_title_attributes
    if image_title.present? && image_title_changed?
      self.image_title_size = image_title.file.size
      self.image_title_content_type = image_title.file.content_type
    end
  end
  
end
