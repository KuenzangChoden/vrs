class AddRoleToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :role, :integer, default: 0
  end
end
