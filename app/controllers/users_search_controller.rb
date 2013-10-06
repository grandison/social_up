class UsersSearchController < ApplicationController
  def index
    @users = current_user.friends.
      with_alarms.
      by_name(params[:by_name]).
      page(params[:page]).per(8)
  end
end
