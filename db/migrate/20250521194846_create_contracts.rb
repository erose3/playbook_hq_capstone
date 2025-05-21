class CreateContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :contracts do |t|
      t.string :contract_name
      t.integer :monetary_compensation
      t.string :other_compensation
      t.integer :created_by
      t.string :token
      t.integer :tasks_count

      t.timestamps
    end
  end
end
