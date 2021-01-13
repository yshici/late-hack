class AddLateTimeToExcuse < ActiveRecord::Migration[6.0]
  def change
    add_column :excuses, :late_time, :integer, null: false
  end
end
