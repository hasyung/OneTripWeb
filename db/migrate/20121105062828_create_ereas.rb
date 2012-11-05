class CreateEreas < ActiveRecord::Migration
  def up
    create_table :ereas do |t|
      t.integer :specialable_id, :null => false
      t.string  :specialable_type, :null => false
      t.integer  :style_type, :default => 0
      t.references  :area_category, :null => false
      t.integer :order, :default => 0
      t.timestamps
    end
  end

  def down
    drop_table :areas
  end
end
