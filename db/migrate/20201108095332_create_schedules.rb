class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :name
      t.datetime :meeting_time
      t.string :destination_name
      t.string :destination_address
      t.float :destination_lat_lng
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
