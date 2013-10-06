class MusicSetsController < ApplicationController
  before_filter :find_alarm
  before_filter :find_music_set, only: [:like]

  def create
    @music_set = @alarm.music_sets.create(params[:music_set])
  end

  def like
    like = current_user.likes.where(music_set_id: @music_set.id)
    if like.present?
      like.destroy_all
    else
      current_user.likes.create(music_set_id: @music_set.id)
    end
  end

  private

  def find_music_set
    @music_set = @alarm.music_sets.find(params[:music_set_id])
  end

  def find_alarm
    @alarm = current_user.friends_alarms.find(params[:alarm_id])
  end
end
