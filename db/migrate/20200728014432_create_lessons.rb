class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.integer :user_id
      t.string :title
      t.integer :fee
      t.string :level
      t.string :place
      t.string :url
      t.string :online

      t.timestamps
    end
  end
end
