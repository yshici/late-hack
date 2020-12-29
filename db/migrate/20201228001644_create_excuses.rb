class CreateExcuses < ActiveRecord::Migration[6.0]
  def change
    create_table :excuses do |t|
      t.string :content

      t.timestamps
    end
  end
end
