class MicropostsController < ApplicationController
  before_action :authenticate_with_token

  def list
    user_id = params[:user_id]
    if User.where(id: user_id).present?
      @microposts = Micropost.where("user_id = ?", user_id)
    else
      render status: :unprocessable_entity, body: "Incorrect user id"
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      render 'show'
    else
      render status: :unprocessable_entity, body: @micropost.errors.full_messages
    end
  end

  def destroy
    if user_owns_micropost
      current_user.microposts.find_by(id: params[:post_id]).destroy
      @microposts = current_user.microposts
      render 'list'
    elsif Micropost.find_by(id: params[:post_id]).present?
      render status: :unauthorized, body: "Unauthorized acction"
    else
      render status: :unprocessable_entity, body: "Incorrect micropost id"
    end
  end


  protected

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def user_owns_micropost
      current_user.microposts.find_by(id: params[:post_id]).present?
    end

end