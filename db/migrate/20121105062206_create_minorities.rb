class CreateMinorities < ActiveRecord::Migration
  def up
    create_table :minorities do |t|
    	t.references	:province,					:null => false
    	t.string			:name,						  :null => false, :limit => 50
    	t.string			:key,						    :null => false,	:limit => 30
    	t.integer			:areas_count,			:default => 0
    	t.string			:keywords,					:limit => 100
    	t.string			:description,				:limit => 1000
    	t.integer			:order,					    :default => 0
      t.integer     :status_cd,			:default => 0
      t.timestamps
    end
    
     add_index :minorities, :name, unique: true
    add_index :minorities, :key, unique: true
  end

  def down
    drop_table :minorities
  end
end
