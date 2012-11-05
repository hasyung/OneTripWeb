class EditProvinces < ActiveRecord::Migration
  def up
    remove_column :provinces, :places_count
    add_column    :provinces, :slug, :string, :null => false
    add_column    :provinces, :specials_count, :integer, :default => 0
    add_index     :provinces, :slug, unique: true
  end
  
  def down
    add_column    :provinces, :places_count, :integer, :default => 0
    remove_column :provinces, :slug
    remove_column :provinces, :specials_count
  end
end
