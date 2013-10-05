class AddLikesCountToMusicSets < ActiveRecord::Migration
  def change
    add_column :music_sets, :likes_count, :integer, default: 0
  end
end
