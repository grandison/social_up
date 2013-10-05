class User < ActiveRecord::Base
  attr_accessible :name, :token, :vk_id
  before_save :set_info

  has_many :alarms
  has_many :likes

  scope :with_alarms, joins(:alarms)

  def vk_client
    @vk_client ||= VkontakteApi::Client.new(token)
  end

  def friends
    User.where(vk_id: vk_client.friends.get(fields: [].map(&:user_id)))
  end

  def friends_alarms
    Alarm.where(user_id: friends.map(&:id))
  end

  def current_alarm
    alarms.last
  end

  private

  def set_info
    if name.blank?
      info = vk_client.users.get(uid:vk_id).first
      self.name = "#{info.first_name} #{info.last_name}"
    end
  end
end
