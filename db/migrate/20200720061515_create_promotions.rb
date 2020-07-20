class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions do |t|
      t.text :content
      t.integer :user_id
      t.integer :writer_id
      
      t.timestamps
    end
  end
end
