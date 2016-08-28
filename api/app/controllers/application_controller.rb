class ApplicationController < ActionController::API
  # show json format in browser
  before_action do
      request.format = :json
  end

  
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token
    render json: { errors: "Not authenticated" },
                status: :unauthorized unless logged_in?
  end

  def logged_in?
    current_user.present?
  end


end
