class AddStartPointToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :start_point_name, :string
    add_column :schedules, :start_point_address, :string
    add_column :schedules, :start_point_lat, :float
    add_column :schedules, :start_point_lng, :float
  end
end
