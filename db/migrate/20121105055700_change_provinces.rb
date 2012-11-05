class ChangeProvinces < ActiveRecord::Migration
  def up
    rename_column :provinces, :specials_count, :places_count
    add_column :provinces, :minorities_count, :integer, :default => 0
  end

  def down
    rename_column :provinces, :places_count, :specials_count
    remove_column :provinces, :minorities_count
  end
end
