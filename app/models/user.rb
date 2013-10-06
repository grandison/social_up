class User < ActiveRecord::Base
  attr_accessible :name, :token, :vk_id, :avatar, :friends_vk_ids

  has_many :alarms
  has_many :likes

  serialize :friends_vk_ids

  scope :with_alarms, joins(:alarms)

  scope :by_name, lambda { |by_name|
    condition = by_name.split(' ').map { |query| " lower(name) LIKE ? " }.join('AND')
    conds = by_name.mb_chars.downcase.split(' ').map { |term| "%#{term}%" }
    where(condition, *conds)
  }

  def frontend_name
    name.split(' ')[0]
  end

  def friends
    User.where(vk_id: friends_vk_ids)
  end

  def friends_alarms
    Alarm.where(user_id: friends.map(&:id))
  end

  def current_alarm
    alarms.last
  end

end
