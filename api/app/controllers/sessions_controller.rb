class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      @current_user = User.find_by(id: session[:user_id])
    else
      render status: :unprocessable_entity, text: user.errors.full_messages
    end
  end

  def destroy
    log_out
  end

end
