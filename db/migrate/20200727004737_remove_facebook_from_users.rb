class RemoveFacebookFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :facebook_url, :string
  end
end
