class BattlesController < ApplicationController
  def new
    @post = Post.find(params[:id])
    @battle = current_user.battles.build
  end

  def create
    @post = Post.find(params[:post_id])
    @battle = current_user.battles.build(battle_params)
    @battle.post_id = @post.id
    
    if @battle.save
      flash[:success] = 'バトルに参加しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'バトル参加に失敗しました。'
      render 'toppages/index'
    end
  end  
end

def battle_params
    params.require(:battle).permit(:imaged, :title)
end
