class AddPromotiontitleUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :promotion_title, :string
  end
end
