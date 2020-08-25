module NotificationsHelper

  def unchecked_notifications
    @notifications=current_user.passive_notifications.where(checked: false)
  end
  
  def notification_form(notification)
    @promotion=nil
    visiter=link_to notification.visiter.name, notification.visiter, style:"font-weight: bold;"
    your_post=link_to 'あなたの投稿', notification.micropost, style:"font-weight: bold;", remote: true
    case notification.action
    when "follow" then
    "#{visiter}があなたをフォローしました"
    when "promotion" then
    @promotion=Promotion.find_by(id:notification.promotion_id).content
    "#{visiter}が#{your_post}にコメントしました"
    end
  end
end
