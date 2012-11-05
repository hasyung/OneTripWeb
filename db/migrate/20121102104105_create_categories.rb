class CreateCategories < ActiveRecord::Migration
  def change
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
