class CreateSpecials < ActiveRecord::Migration
  def change
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
  end
end
