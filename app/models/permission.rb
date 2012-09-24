class Permission < ActiveRecord::Base
  attr_accessible :name, :action, :description, :subject_class, :subject_id

  # Associations
  has_and_belongs_to_many :roles
end
