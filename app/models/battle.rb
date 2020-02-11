class Battle < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
   #お気に入り機能追加用中間テーブル追加
  has_many :seclikes, foreign_key: 'battle_id', dependent: :destroy
  has_many :secliked, through: :seclikes, source: :user
  
  mount_uploader :imaged, ImagedUploader       #画像を投稿するため
 # self.inheritance_column = :_type_disabled  #typeカラムがそのままだと使えないため
 
 
 validates :title, length: { maximum: 30 }
end
