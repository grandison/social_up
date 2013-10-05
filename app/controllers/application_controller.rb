class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    user = User.find_by_vk_id(params[:viewer_id]) || User.new(vk_id: params[:viewer_id])
    user.token = params[:access_token]
    user.save
    user
  end
end
