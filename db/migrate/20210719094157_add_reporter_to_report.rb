class AddReporterToReport < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :reporter, :int, default: 0
  end
end
