class AddStatusCdToPlaces < ActiveRecord::Migration
  def change
  	add_column :places, :status_cd, :integer, :default => 0
  end
end
