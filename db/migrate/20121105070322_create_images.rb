class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
     t.references  :area, :null => false
    	t.string  :name, :null => false
    	t.string  :image
    	t.integer :image_size, :default => 0
    	t.string  :image_content_type
      t.timestamps
    end
  end

  def down
    drop_table :images
  end
end
