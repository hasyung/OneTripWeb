class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
    	t.string		:name,					:null => false, :limit => 30
    	t.string		:key,						:null => false, :limit => 30
    	t.integer		:places_count,	:default => 0
      t.timestamps
    end

    add_index :provinces, :name, unique: true
    add_index :provinces, :key, unique: true
  end
end
