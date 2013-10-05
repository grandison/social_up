class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.string :time
      t.integer :user_id

      t.timestamps
    end
  end
end
