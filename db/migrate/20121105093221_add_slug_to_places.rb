class AddSlugToPlaces < ActiveRecord::Migration
  def up
    add_column :places, :slug, :string, :null => false
  end

  def down
    remove_column :places, :slug
  end
end
