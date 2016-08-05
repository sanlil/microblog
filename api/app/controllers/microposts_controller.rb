class MicropostsController < ApplicationController
    
  def show
    @micropost = Micropost.find(params[:id])
  end

  def list
    @microposts = Micropost.all
  end

end