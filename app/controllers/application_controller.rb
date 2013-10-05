class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :create_friends

  def create_friends
    if current_user.friends.count < 10
      current_user.vk_client.friends.get(fields: [:photo_medium]).each do |friend_params|
        user = User.create(vk_id: friend_params.uid, avatar: friend_params[:photo_medium], name: "#{friend_params[:first_name]} #{friend_params[:last_name]}")
        user.alarms.create(time: "08:00")
      end
    end
  end

  def current_user
    if params[:viewer_id] && params[:access_token]
      user = User.find_by_vk_id(params[:viewer_id]) || User.new(vk_id: params[:viewer_id])
      user.token = params[:access_token] if params[:access_token]
      session[:user_id] = user.id
      user.save
    else
      session[:user_id] = 311 if session[:user_id].blank?
      user = User.find(session[:user_id])
    end
    
    user
  end
end
