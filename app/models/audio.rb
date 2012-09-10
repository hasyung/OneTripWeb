class Audio < ActiveRecord::Base
  attr_accessible :name, :place_id, :category_cd, :duration, :attachment, :order

  # Associations
  belongs_to :place, :counter_cache => true

  # Validates
  validates :name, :place_id, :category_cd, :duration, :attachment, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..30 }
    name.validates :name, :uniqueness => true
  end
  validates_attachment :attachment, 
    :size => { :in => 0..10.megabytes.to_i },
    :content_type => { :content_type => %w(audio/mp3) }


end
