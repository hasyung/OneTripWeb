class AddIndexToAreas < ActiveRecord::Migration
  def up
    add_index :areas, [ :areable_type, :areable_id, :area_category_id ], unique: true
  end
  
  def down
    remove_index :areas, [ :areable_type, :areable_id, :area_category_id ], unique: true
  end
end
