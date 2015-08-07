class CreatePermissionsRoles < ActiveRecord::Migration
  def change
    create_table :permissions_roles do |t|
      t.references :role, index: true, foreign_key: true
      t.references :permission, index: true, foreign_key: true
    end
  end
end
