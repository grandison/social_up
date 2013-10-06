class ApplicationController < ActionController::Base
  # protect_from_forgery
  helper_method :current_user
  before_filter :fetch_data


  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  def fetch_data
    if request.format.html? && current_user.name.blank?
      redirect_to :fetch_data_users
    end
  end

  def current_user
    if params[:viewer_id] && params[:access_token]
      user = User.find_by_vk_id(params[:viewer_id]) || User.new(vk_id: params[:viewer_id])
      user.token = params[:access_token] if params[:access_token]
      session[:user_id] = user.id
      user.save
    else
      # session[:user_id] = 311 if session[:user_id].blank?
      user = User.find(session[:user_id])
    end

    user
  end


end
