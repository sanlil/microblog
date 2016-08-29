class MicropostsController < ApplicationController
  before_action :authenticate_with_token

  def list
    user_id = params[:user_id]
    if User.where(id: user_id).present?
      @microposts = Micropost.where(:user_id => user_id)
    else
      render status: :unprocessable_entity, body: "Incorrect user id"
    end
  end

  def create
    @micropost = Micropost.new
    @micropost.content = params[:content]
    @micropost.user_id = current_user.id
    if @micropost.save
      render 'show'
    else
      render status: :unprocessable_entity, body: @micropost.errors.full_messages
    end
  end

end