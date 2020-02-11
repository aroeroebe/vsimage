class CreateSeclikes < ActiveRecord::Migration[5.2]
  def change
    create_table :seclikes do |t|
      t.references :user, foreign_key: true
      t.references :battle, foreign_key: true

      t.timestamps
    end
  end
end
