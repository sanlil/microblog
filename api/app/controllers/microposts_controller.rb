class MicropostsController < ApplicationController
    
  def show
    @micropost = Micropost.find(params[:id])
  end

  def list
    @microposts = Micropost.all
  end

  def create
    @micropost = Micropost.new
    @micropost.content = params[:content]
    @micropost.user_id = params[:user_id]
    if @micropost.save
      render 'show'
    else
      render(json: { errors: @user.errors.full_messages, status: 422})
    end
  end

end