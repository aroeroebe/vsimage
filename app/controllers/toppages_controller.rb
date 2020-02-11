class ToppagesController < ApplicationController
  def index
    @posts = Post.all.order(id: :desc).page(params[:page]).per(4)
    @battles = Battle.all.order(id: :desc).page(params[:page]).per(4)
    @time = Time.current
  end
end
