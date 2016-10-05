class ApplicationController < ActionController::API
  # show json format in browser
  before_action do
      request.format = :json
  end

  
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token
    unless logged_in?
      render json: { errors: "Not authenticated" }, status: :unauthorized
    end
  end

  def logged_in?
    current_user.present?
  end


end
