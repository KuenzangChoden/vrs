class AddConclusionDateToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :conclusion_date, :datetime
    
  end
end
