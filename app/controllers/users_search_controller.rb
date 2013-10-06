class UsersSearchController < ApplicationController
  def index
    @users = current_user.friends.
      by_name(params[:term])

    render json: @users
  end

  def render_user
    @user = current_user.friends.find(params[:user_id])
  end
end
