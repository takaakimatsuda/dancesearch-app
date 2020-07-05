class AddColumnUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :genre, :string
    add_column :users, :team_name, :string
    add_column :users, :pref1, :string
    add_column :users, :pref2, :string
    add_column :users, :pref3, :string
    add_column :users, :carrer, :text
    add_column :users, :lesson_comment, :text
    add_column :users, :movie_url, :string
    add_column :users, :promotion_url, :string
  end
end
