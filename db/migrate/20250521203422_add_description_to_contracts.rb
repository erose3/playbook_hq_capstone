class AddDescriptionToContracts < ActiveRecord::Migration[7.1]
  def change
    add_column :contracts, :description, :text
  end
end
