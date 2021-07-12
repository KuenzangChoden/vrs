class DeleteStatusFromReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :status
  end
end
