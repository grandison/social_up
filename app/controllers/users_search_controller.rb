class UsersSearchController < ApplicationController
  def index
    @users = current_user.friends.
      with_alarms.
      by_name(params[:term])

    Rails.logger.info "--------#{@users.count}"

    render json: @users
  end
end
