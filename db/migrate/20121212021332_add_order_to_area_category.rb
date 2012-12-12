class AddOrderToAreaCategory < ActiveRecord::Migration
  def up
    add_column :area_categories, :order, :integer, :default => 0
  end
  def down
    remove_column :area_categories, :order
  end
end
