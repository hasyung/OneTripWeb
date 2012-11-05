class AddCategoryCdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :category_cd, :integer, :default => 0
  end
end
