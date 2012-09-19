class RemoveCategoryCdFromVideos < ActiveRecord::Migration
  def up
  	remove_column :videos, :category_cd
  end

  def down
  	add_column :videos, :category_cd, :integer, :default => 0
  end
end
