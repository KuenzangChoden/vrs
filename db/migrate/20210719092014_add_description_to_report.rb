class AddDescriptionToReport < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :description, :string
  end
end
