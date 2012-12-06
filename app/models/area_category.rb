class AreaCategory < ActiveRecord::Base
	attr_accessible :name, :description, :style_type_cd, :category_cd

  # Associations
  belongs_to :area, :dependent => :destroy
  
  #SimpleEnum
  as_enum :style_type, { :style_0 => 0, :style_1 => 1, :style_2 => 2, :style_3 => 3, :style_4 => 4, :style_5 => 5, :style_6 => 6, :style_7 => 7, :style_8 => 8 }
  as_enum :category, { :place => 0, :minority => 1 }

  # Validates
  validates :name, :style_type, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..20 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :description? do |description|
  	description.validates :description, :length => { :within => 2..100 }
  end
  
  # Scopes
  scope :created_desc, order("created_at DESC")
  scope :search_name, lambda { |name| where("ucase(`area_categories`.`name`) like concat('%',ucase(?),'%')", name) }
  scope :place, where(:category_cd => AreaCategory.place)
  scope :minority, where(:category_cd => AreaCategory.minority)
  
  def decide_purview(model)
    result = false
    case model.name
    when "Image"
      if self.style_type_cd == 0 || self.style_type_cd == 6
        result = true
      end
    when "Article"
      if (3..7).include?(self.style_type_cd)
        result = true
      end
    when "Audio"
      if self.style_type_cd == 2 || self.style_type_cd == 8
        result = true
      end
    when "Info"
      if self.style_type_cd == 0
        result = true
      end
    when "Video"
      if self.style_type_cd == 1 || self.style_type_cd == 7
        result = true
      end
    end
    result
  end
end
