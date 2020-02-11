class User < ApplicationRecord
  attr_accessor :remember_token
  
  has_secure_password
  
 has_many :posts
 has_many :battles
 has_many :likes
 has_many :likings, through: :likes, source: :post
 has_many :seclikes
 has_many :seclikings, through: :seclikes, source: :battle
 
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
 
 
 
 # 自動ログイン----------------------------------------------------------------
 
                    
  # ランダムなトークンを返す
  def self.new_token #User.new_tokenと同じ意味
  SecureRandom.urlsafe_base64
  end
  
  # 与えられた文字列のハッシュ値を返す
  def self.digest(string) #User.digest(string)を同じ意味
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
  end

  # 永続的セッションで使用するユーザーをデータベースに記憶する
  def remember
  self.remember_token = User.new_token
  update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
  return false if remember_digest.nil?
  BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
  update_attribute(:remember_digest, nil)
  end
  
 
 #お気に入り機能-------------------------------------------------------------------------- 
  
  #お気に入り追加
  def like(post)
    likes.find_or_create_by(post_id: post.id)
  end

  #お気に入り削除
  def unlike(post)
    like = likes.find_by(post_id: post.id)
    like.destroy if like
  end

  #お気にり登録判定
  def liking?(post)
    self.likings.include?(post)
  end
  
  #お気に入り追加(battle)
  def seclike(battle)
    seclikes.find_or_create_by(battle_id: battle.id)
  end

  #お気に入り削除(battle)
  def secunlike(battle)
    seclike = seclikes.find_by(battle_id: battle.id)
    seclike.destroy if seclike
  end

  #お気にり登録判定(battle)
  def secliking?(battle)
    self.seclikings.include?(battle)
  end
  
 
#-------------------------------------------------------------------------------------------  
  
end
