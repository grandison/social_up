class ApplicationController < ActionController::Base
  protect_from_forgery
  # helper_method :current_user

  # def current_user
  #   if params[:viewer_id] && params[:access_token]
  #     user = User.find_by_vk_id(params[:viewer_id]) || User.new(vk_id: params[:viewer_id])
  #     user.token = params[:access_token] if params[:access_token]
  #     session[:user_id] = user.id
  #     user.save
  #   else
  #     user = User.find(session[:user_id])
  #   end
  #   user
  # end
end
