class AddImageTitleToMinorities < ActiveRecord::Migration
  def up
    add_column :minorities, :image_title, :string
    add_column :minorities, :image_title_size, :integer, :default => 0
    add_column :minorities, :image_title_content_type, :string
  end
  
  def down
    remove_column :minorities, :image_title
    remove_column :minorities, :image_title_size
    remove_column :minorities, :image_title_content_type
  end
end
