class RenameStyleType < ActiveRecord::Migration
  def up
    rename_column :area_categories, :style_type, :style_type_cd
  end

  def down
    rename_column :area_categories, :style_type_cd, :style_type
  end
end
