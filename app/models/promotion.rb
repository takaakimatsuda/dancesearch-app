class Promotion < ApplicationRecord
  belongs_to :user
  belongs_to :writer, class_name: 'User', foreign_key: :writer_id
end
