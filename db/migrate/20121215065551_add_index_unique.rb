class AddIndexUnique < ActiveRecord::Migration
  def up
    add_index :area_categories, :name, unique: true
    add_index :audios, [ :area_id, :name ], unique: true
    add_index :articles, [ :area_id, :title ], unique: true
  end
  
  def down
    remove_index :area_categories, :name, unique: true
    remove_index :audios, [ :area_id, :name ], unique: true
    remove_index :articles, [ :area_id, :title ], unique: true
  end
end
