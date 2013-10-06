class AddFriendsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friends_vk_ids, :text
  end
end
