class ChangePlaces < ActiveRecord::Migration
  def up
    remove_column :places, :videos_count
    remove_column :places, :audios_count
    remove_column :places, :articles_count
    remove_column :places, :infos_count
    remove_column :places, :map
    remove_column :places, :map_size
    remove_column :places, :map_content_type
    add_column :places, :areas_count, :integer, :default => 0
  end

  def down 
    add_column :places, :videos_count, :integer, :default => 0
    add_column :places, :audios_count, :integer, :default => 0
    add_column :places, :articles_count, :integer, :default => 0
    add_column :places, :infos_count, :integer, :default => 0
    add_column :places, :map, :string, :null => false
    add_column :places, :map_size, :integer, :default => 0
    add_column :places, :map_content_type, :string
    remove_column :places, :areas_count
  end
end
