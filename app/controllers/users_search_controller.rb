class UsersSearchController < ApplicationController
  def index
    @users = current_user.friends.
      with_alarms.
      by_name(params[:term])

    render json: @users
  end

  def render_user
    @user = current_user.friends.with_alarms.find(params[:user_id])
  end
end
