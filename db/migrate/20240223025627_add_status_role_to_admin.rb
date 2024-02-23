class AddStatusRoleToAdmin < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :status, :integer, default: 1
    add_column :admins, :role, :integer, default: 1
  end
end
