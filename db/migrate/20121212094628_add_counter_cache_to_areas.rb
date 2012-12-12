class AddCounterCacheToAreas < ActiveRecord::Migration
  def up
    add_column :areas, :videos_count, :integer, :default => 0
    add_column :areas, :audios_count, :integer, :default => 0
    add_column :areas, :images_count, :integer, :default => 0
    add_column :areas, :infos_count, :integer, :default => 0
    add_column :areas, :articles_count, :integer, :default => 0
  end
  def down
    remove_column :areas, :videos_count
    remove_column :areas, :audios_count
    remove_column :areas, :images_count
    remove_column :areas, :infos_count
    remove_column :areas, :articles_count
  end
end
