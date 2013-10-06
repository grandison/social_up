class AlarmsController < ApplicationController
  def index
    @alarms = current_user.alarms
  end

  def friends
    @users = current_user.friends.with_alarms.page(params[:page]).per(10)
  end

  def show
    @alarm = current_user.friends_alarms.find(params[:id])
    @music_set = @alarm.music_sets.new
  end
end
