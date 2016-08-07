class UsersController < ApplicationController
    
  def show
    #puts params.inspect
    @user = User.find(params[:id])
    #@ => instansvariable => finns i vyn
    #@user = User.where(...)
    #render '/_user' #vyn (annars users/show.json.jbuilder)
  end

  def list
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'show'
    else
      # render(json: { errors: @user.errors.full_messages, status: 422})
      render status: :unprocessable_entity, text: @user.errors.full_messages
    end
  end



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
