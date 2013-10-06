class AddAuthorToMusicSets < ActiveRecord::Migration
  def change
    add_column :music_sets, :author, :string
  end
end
