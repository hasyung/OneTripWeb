class CreatePermissionRoleJoinTable < ActiveRecord::Migration
  def change
    create_table :permissions_roles, :id => false do |t|
      t.references :permission
      t.references :role
    end
  end
end
