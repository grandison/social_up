class User < ActiveRecord::Base
  attr_accessible :name, :token, :vk_id, :avatar
  before_save :set_info

  has_many :alarms
  has_many :likes

  scope :with_alarms, joins(:alarms)

  scope :by_name, lambda { |by_name|
    condition = by_name.split(' ').map { |query| " lower(name) LIKE ? " }.join('AND')
    conds = by_name.downcase.split(' ').map { |term| "%#{term}%" }
    where(condition, *conds)
  }

  def frontend_name
    name.split(' ')[0]
  end

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
    if name.blank? || avatar.blank?
      info = vk_client.users.get(uid:vk_id, fields: [:photo_medium]).first
      self.name = "#{info.first_name} #{info.last_name}"
      self.avatar = info.photo_medium
    end
  end
end
