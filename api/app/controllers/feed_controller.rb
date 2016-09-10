class FeedController < ApplicationController
  before_action :authenticate_with_token

  def show
    @feed = current_user.feed
  end

end