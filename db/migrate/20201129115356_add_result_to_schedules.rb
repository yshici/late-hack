class AddResultToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :result, :text
  end
end
