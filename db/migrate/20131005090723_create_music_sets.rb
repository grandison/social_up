class CreateMusicSets < ActiveRecord::Migration
  def change
    create_table :music_sets do |t|

      t.timestamps
    end
  end
end
