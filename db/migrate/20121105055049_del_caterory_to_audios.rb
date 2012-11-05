class DelCateroryToAudios < ActiveRecord::Migration
  def up
    remove_column :audios, :category_cd
    rename_column :audios, :place_id, :area_id
  end

  def down
    add_column :audios, :category_cd, :integer, :default => 0
    rename_column :audios, :area_id, :place_id
  end
end
