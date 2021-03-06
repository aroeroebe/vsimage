class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
    if logged_in?
    @post = current_user.posts.build  # form_with 用
    end
  end
  
  

  def create
    @post = current_user.posts.build(post_params)
  
    if @post.save
      flash[:success] = '画像を投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '画像の投稿に失敗しました。'
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
 

  private

  def post_params
    params.require(:post).permit(:image, :title ,:remove_image)
  end
  
  
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
