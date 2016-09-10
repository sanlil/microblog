class SessionsController < ApplicationController
  before_action :authenticate_with_token, except: [:create]

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password]) && @user.save
      @login = true
      render template: 'users/show'
    else
      render status: :unprocessable_entity, body: "Incorrect email or password"
    end
  end

  def destroy
    user = current_user
    user.generate_authentication_token
    user.save!
    head :no_content
  end

end
