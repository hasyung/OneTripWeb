class AddBodyToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :body, :string
  end
end
