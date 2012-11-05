class DropTables < ActiveRecord::Migration
  def up
    drop_table :specials
    drop_table :categories
  end

  def down
    create_table :specials do |t|
      t.references  :category,       :null => false
      t.references  :province,       :null => false
      t.string      :name,           :null => false
      t.string      :key,            :null => false
      t.string      :slug,           :null => false
      t.string      :keywords
      t.string      :description
      t.integer     :order
      t.integer     :areas_count,    :default => 0
      t.integer     :status_cd,      :default => 0
      t.timestamps
    end
    add_index :specials, :name, unique: true
    add_index :specials, :key,  unique: true
    add_index :specials, :slug, unique: true
    
    create_table :categories do |t|
      t.string      :name,           :null => false
      t.string      :key,            :null => false
      t.string      :slug,           :null => false
      t.integer     :specials_count, :default => 0
      t.timestamps
    end
    add_index :categories, :name,  unique: true
    add_index :categories, :key,  unique: true
    add_index :categories, :slug, unique: true
  end
end
