class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
    	t.references	:place,						:null => false
    	t.string			:var,							:null => false, :limit => 100
    	t.string			:value
    	t.integer			:order,						:default => 0
      t.timestamps
    end

    add_index :infos, [ :place_id, :var ], :unique => true
  end
end
