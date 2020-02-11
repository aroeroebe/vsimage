module LikesHelper
  def post_count(post)
    post.liked.count
  end
  
  def battle_count(battle)
    battle.secliked.count
  end
  
end