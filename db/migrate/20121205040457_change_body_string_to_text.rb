class ChangeBodyStringToText < ActiveRecord::Migration
  def up
    change_column :videos, :body, :text
    change_column :audios, :body, :text
  end

  def down
    change_column :videos, :body, :string
    change_column :audios, :body, :string
  end
end
