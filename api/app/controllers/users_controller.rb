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

end