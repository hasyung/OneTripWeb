class AddSubtitleToMinorities < ActiveRecord::Migration
  def up
    add_column :minorities, :subtitle, :string, :limit => 100
  end
  def down
    remove_column :minorities, :subtitle
  end
end
