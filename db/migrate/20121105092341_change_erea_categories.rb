class ChangeEreaCategories < ActiveRecord::Migration
  def up
    rename_table :erea_categories, :area_categories
  end

  def down
     rename_table  :area_categories, :erea_categories
  end
end
