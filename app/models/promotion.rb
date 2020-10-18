class Promotion < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  belongs_to :writer, class_name: 'User', foreign_key: :writer_id
  has_many :notifications, dependent: :destroy
  validates :content, presence: true, length: { maximum: 500 }

  def create_notification_promotion!(current_user, promotion_id)
    notifications = Notification.where(visitor_id: current_user.id, visited_id: promotion_id, action: 'promotion')
    if notifications.blank?
      notification = current_user.active_notifications.new(
        promotion_id: self.id,
        visited_id: user_id,
        action: 'promotion'
      )
      notification.save! if notification.valid?
    end
  end
end
