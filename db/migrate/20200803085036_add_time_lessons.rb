class AddTimeLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :time, :string
  end
end
