class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
    	t.string			:name,									:null => false
    	t.string			:image
    	t.integer			:image_size,						:default => 0
    	t.string			:image_content_type
      t.timestamps
    end
  end
end
