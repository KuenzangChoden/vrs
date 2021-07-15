class AddAdminIdToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :admin_id, :integer
    add_index :reports, :admin_id
  end
end
