class ChangeEreas < ActiveRecord::Migration
  def up
    rename_column :ereas, :specialable_id, :areable_id
    rename_column :ereas, :specialable_type, :areable_type
    rename_table :ereas, :areas
  end

  def down
    rename_column :areas, :areable_id, :specialable_id
    rename_column :areas, :areable_type, :specialable_type
    rename_table :areas, :ereas
  end
end
