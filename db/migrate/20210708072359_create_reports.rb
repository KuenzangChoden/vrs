class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.integer :vtype

      t.timestamps
    end
  end
end
