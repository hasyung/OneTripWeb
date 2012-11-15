class AddDescriptionToArea < ActiveRecord::Migration
  def up
    add_column :areas, :description, :string, :limit => 1000
  end
  def down
    remove_column :areas, :description
  end
end
