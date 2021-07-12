class ChangeVtypeInReport < ActiveRecord::Migration[6.1]
  def change
    change_column :reports, :vtype, :integer, null: false, default: 0

  end
end
