class CreateUserProfiles < ActiveRecord::Migration
  def up
    create_table :user_profiles do |t|
      t.references :user
      t.string :real_name, :null => false, :default => "", :limit => 20
      t.integer :sex_cd, :null => false, :default => 0
      t.string :position, :limit => 30
      t.timestamps
    end
  end
  def down
    drop_table:user_profiles
  end
end
