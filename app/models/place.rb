class Place < ActiveRecord::Base
  attr_accessible :name, :key, :keywords, :description, :map, :order

  # Associations
  belongs_to :category, :counter_cache => true
end
