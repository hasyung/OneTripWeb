class AddOrderToImages < ActiveRecord::Migration
  def up
    add_column :images, :order, :integer, :default => 0
  end
  def down
    remove_column :images, :order
  end
end
