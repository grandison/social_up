class AddAlarmIdToMusicSets < ActiveRecord::Migration
  def change
    add_column :music_sets, :alarm_id, :integer
    add_index :music_sets, :alarm_id
  end
end
