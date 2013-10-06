class UsersController < ApplicationController
  def fetch_data
  end

  def update
    current_user.update_attributes(params[:user])
    render json: current_user
  end
end
