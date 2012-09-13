class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
    	t.references	:province,					:null => false
    	t.string			:name,						  :null => false, :limit => 50
    	t.string			:key,						    :null => false,	:limit => 30
    	t.integer			:videos_count,			:default => 0
    	t.integer			:audios_count,			:default => 0
    	t.integer			:articles_count,		:default => 0
    	t.integer			:infos_count,				:default => 0
    	t.string			:keywords,					:limit => 100
    	t.string			:description,				:limit => 1000
      t.string			:map,						    :null => false
    	t.integer			:map_size,					:default => 0
    	t.string			:map_content_type
    	t.integer			:order,					    :default => 0
      t.timestamps
    end

    add_index :places, :name, unique: true
    add_index :places, :key, unique: true
    
  end
end
