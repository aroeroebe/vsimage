class SeclikesController < ApplicationController
  def create
    battle = Battle.find(params[:battle_id])
    current_user.seclike(battle)
    flash[:success] = 'お気に入り登録をしました。'
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    battle = Battle.find(params[:battle_id])
    current_user.secunlike(battle)
    flash[:success] = 'お気に入り登録を解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
