class Api::V1::UsersController  < Api::V1::BaseController

  def index
    users = User.all
    render status: 200, json: users
  end

  def update
    user = User.find(params[:id])
    user.current_alarm = params[:time]
    user.save
    render status: 200, json: user
  end
end