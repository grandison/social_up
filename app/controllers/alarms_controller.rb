class AlarmsController < ApplicationController
  skip_before_filter :fetch_data, only: [:create]
  
  def index
    @alarms = current_user.alarms
  end

  def friends
    @users = current_user.friends.page(params[:page]).per(10)
  end

  def show
    @css_class = 'alarm_details'
    @alarm = Alarm.find(params[:id])
    @music_set = @alarm.music_sets.new
    respond_to do |format|
      format.html
      format.json{ render json: @alarm }
    end
  end

  def create
    @alarm = Alarm.create(params[:alarm])
    render json: @alarm
  end
end
