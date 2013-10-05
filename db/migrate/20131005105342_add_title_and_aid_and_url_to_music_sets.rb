class AddTitleAndAidAndUrlToMusicSets < ActiveRecord::Migration
  def change
    add_column :music_sets, :title, :string
    add_column :music_sets, :aid, :integer
    add_column :music_sets, :url, :string
  end
end
