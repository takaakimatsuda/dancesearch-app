class Promotion < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  belongs_to :writer, class_name: 'User', foreign_key: :writer_id
  has_many :notifications, dependent: :destroy

  def create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      promotion_id:self.id,
      visited_id:user_id,
      action:"promotion"
    )
    notification.save if notification.valid?
  end
end
