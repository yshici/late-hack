class CreateExcuseSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :excuse_schedules do |t|
      t.references :schedule, null: false, foreign_key: true
      t.references :excuse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
