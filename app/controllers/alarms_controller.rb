class AlarmsController < ApplicationController
  def index
    @alarms = current_user.alarms
  end

  def friends
    @alarms = current_user.friends_alarms
  end
end
