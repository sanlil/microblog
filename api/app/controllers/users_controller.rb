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
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      render 'show'
    else
      render(json: { errors: @user.errors.full_messages, status: 422})
    end
  end
  
end