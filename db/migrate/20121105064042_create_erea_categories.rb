class CreateEreaCategories < ActiveRecord::Migration
  def up
    create_table :erea_categories do |t|
      t.string :name, :null => false, :limit => 50
      t.string  :description, :limit => 1000
      t.timestamps
    end
  end

  def down
    drop_table :erea_categories
  end
end
