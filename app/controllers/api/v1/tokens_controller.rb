class Api::V1::TokensController  < Api::V1::BaseController
  def show
    user = User.find_by_vk_id(params[:id])
    render status: 200, json: user.token
  end
end