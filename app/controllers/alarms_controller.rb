class AlarmsController < ApplicationController
  def index
    @alarms = current_user.alarms
  end

  def friends
    @users = current_user.friends.with_alarms.page(params[:page]).per(8)
  end

  def show
    @alarm = Alarm.find(params[:id])
    @music_set = @alarm.music_sets.new
    respond_to do |format|
      format.html
      format.json{ render json: @alarm }
    end
  end

  def create
    Alarm.create(params[:alarm])
    render status: 200, json: "Ok"
  end
end
