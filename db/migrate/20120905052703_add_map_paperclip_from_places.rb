class AddMapPaperclipFromPlaces < ActiveRecord::Migration
  def change
  	add_attachment :places, :map
  end
end
