class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
    	t.references	:place,											:null => false
    	t.string			:name,											:null => false
    	t.integer			:category_cd,								:null => false, :default => 0
    	t.integer			:duration,									:default => 0
    	t.string			:attachment
    	t.string			:attachment_name
    	t.integer			:attachment_size,						:default => 0
    	t.string			:attachment_content_type
    	t.integer			:order,											:default => 0
      t.timestamps
    end
  end
end
