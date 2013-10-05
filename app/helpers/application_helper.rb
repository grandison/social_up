module ApplicationHelper
  def friends_alarms_path?
    current_page?(friends_alarms_path) || current_page?(root_path) || (params[:controller] == "alarms" && params[:action] == "show")
  end
end
