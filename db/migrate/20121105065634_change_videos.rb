class ChangeVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :category_cd
    remove_column :videos, :name
    rename_column :videos, :place_id, :area_id
  end

  def down
    add_column :videos, :category_cd, :integer, :default => 0
    add_colunm :videos, :name, :string, :null => false
    rename_column :videos, :area_id, :place_id
  end
end
