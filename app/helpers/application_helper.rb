module ApplicationHelper
  def friends_alarms_path?
    current_page?(friends_alarms_path) || current_page?(root_path) || (params[:controller] == "alarms" && params[:action] == "show")
  end

  def liked_it?(music_set)
    current_user.likes.where(music_set_id: music_set.id).present? ? 'my_like' : ''
  end
end
