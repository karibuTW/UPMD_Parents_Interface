class CreateBusServices < ActiveRecord::Migration[6.1]
  def change
    create_table :bus_services do |t|
      t.string :year
      t.references :parent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
