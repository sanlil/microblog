class ApplicationController < ActionController::API
  # show json format in browser
  before_action do
      request.format = :json
  end

  # Places a temporary cookie on the user’s browser containing an encrypted version of the user’s id
  def log_in(user)
    session[:user_id] = user.id
  end
  #helper_method :log_in

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  #helper_method :current_user

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  #helper_method :logged_in?

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  #helper_method :log_out

end
