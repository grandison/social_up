class User < ActiveRecord::Base
  attr_accessible :name, :token, :vk_id

  has_many :alarms

  def vk_client
    @vk_client ||= VkontakteApi::Client.new(token)
  end

  def friends
    User.where(vk_id: vk_client.friends.get(fields: [].map(&:user_id))).to_a
  end
end
