class CreateBattles < ActiveRecord::Migration[5.2]
  def change
    create_table :battles do |t|
      t.string :title
      t.string :imaged
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
