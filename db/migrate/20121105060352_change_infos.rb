class ChangeInfos < ActiveRecord::Migration
  def up
    rename_column :infos, :place_id, :area_id
    remove_index :infos, [ :place_id, :var ]
    add_index :infos, [ :area_id, :var ], :unique => true
  end

  def down
     rename_column :infos, :area_id, :place_id
     remove_index :infos, [ :area_id, :var ]
     add_index :infos, [ :place_id, :var ], :unique => true
  end
end
