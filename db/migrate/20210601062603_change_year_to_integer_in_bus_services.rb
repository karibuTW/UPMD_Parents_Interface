class ChangeYearToIntegerInBusServices < ActiveRecord::Migration[6.1]
  def change
    change_column :bus_services, :year, 'integer USING CAST(year AS integer)'
  end
end
