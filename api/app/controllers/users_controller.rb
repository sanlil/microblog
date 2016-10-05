class UsersController < ApplicationController
  before_action :authenticate_with_token, except: [:show, :list, :create]
    
  def show
    @user = User.find(params[:id])
  end

  def show_current
    @user = current_user
    render 'show'
  end

  def list
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @login = true
      render 'show'
    else
      render status: :unprocessable_entity, json: {errors: @user.errors.full_messages}
    end
  end


  # Protected methods
  protected

  def user_params
    params.require(:user).permit(
      :email,
      :name,
      :password,
      :password_confirmation
    )
  end

end
