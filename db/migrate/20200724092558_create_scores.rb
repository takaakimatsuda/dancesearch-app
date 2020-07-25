class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.integer :user_id
      t.integer :writer_id
      t.integer :point, null: false, default: 0
      t.timestamps
    end
  end
end
