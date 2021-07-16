class AddInvestigationDateToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :investigation_date, :datetime
  end
end
