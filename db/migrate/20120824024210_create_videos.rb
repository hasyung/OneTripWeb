class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    	t.references	:place,											:null => false
    	t.string			:name,											:null => false
    	t.integer			:category_cd,								:null => false, :default => 0
    	t.string		  :duration
    	t.string			:attachment
    	t.integer			:attachment_size,						:default => 0
    	t.string			:attachment_content_type
    	t.string			:cover
    	t.integer			:cover_size,								:default => 0
    	t.string			:cover_content_type
    	t.integer			:order,											:default => 0
      t.timestamps
    end
  end
end
