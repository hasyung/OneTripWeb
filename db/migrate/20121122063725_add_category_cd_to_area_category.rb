class AddCategoryCdToAreaCategory < ActiveRecord::Migration
  def up
    add_column :area_categories, :category_cd, :integer, :default => 0
  end
  def down
    remove_column :area_categories, :category_cd
  end
end
