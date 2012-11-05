class DelCateroryToArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :category_cd
    rename_column :articles, :place_id, :area_id
  end

  def down
    add_column :article, :category_cd, :integer, :default => 0
    rename_column :articles, :area_id, :place_id
  end
end
