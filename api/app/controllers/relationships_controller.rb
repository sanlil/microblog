class RelationshipsController < ApplicationController
  before_action :authenticate_with_token

  def create
    if User.where(id: params[:followed_id]).present?
      user_followed = User.find(params[:followed_id])
      current_user.follow(user_followed)
    else
      render status: :unprocessable_entity, body: "Incorrect user id"
    end
  end

  def destroy
    if Relationship.where(followed_id: params[:followed_id]).present?
      if current_user.active_relationships.find_by(followed_id: params[:followed_id])
        current_user.unfollow(User.find(params[:followed_id]))
      else
        render status: :unauthorized, body: "Unauthorized action"
      end
    else
      render status: :unprocessable_entity, body: "Non-existing relationship"
    end
  end
end