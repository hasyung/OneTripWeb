class RemoveMapFromPlaces < ActiveRecord::Migration
  def up
  	remove_column :places, :map
  	remove_column :places, :map_name
  	remove_column :places, :map_size
  	remove_column :places, :map_content_type
  end

  def down
  	add_column :places, :map, 							:string, 	:null => false
  	add_column :places, :map_name, 					:string, 	:null => false
  	add_column :places, :map_size, 					:integer, :default => 0
  	add_column :places, :map_content_type, 	:string
  end
end
