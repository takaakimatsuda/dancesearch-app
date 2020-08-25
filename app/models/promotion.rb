class Promotion < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  belongs_to :writer, class_name: 'User', foreign_key: :writer_id
  has_many :notifications, dependent: :destroy

  def create_notification_promotion!(current_user, promotion_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Promotion.select(:user_id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_promotion!(current_user, promotion_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_promotion!(current_user, promotion_id, user_id) if temp_ids.blank?
  end
  def save_notification_promotion!(current_user, promoton_id, visited_id)
    notification = current_user.active_notifications.new(
      promotion_id:self.id,
      visited_id:user_id,
      action:"promotion"
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
