class AddGenderToReport < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :gender, :int
  end
end
