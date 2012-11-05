class AddSlugToMinorities < ActiveRecord::Migration
  def up
    add_column :minorities, :slug, :string, :null => false
  end

  def down
    remove_column :minorities, :slug
  end
end
