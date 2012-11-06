class ChangeStyletypeToAreaCategory < ActiveRecord::Migration
  def up
    remove_column :areas, :style_type
    add_column :area_categories, :style_type, :integer, :default => 0
  end

  def down
    remove_column :area_categories, :style_type
    add_column :areas, :style_type, :integer, :default => 0
  end
end
