class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :avatar
  has_many :promotions, dependent: :destroy
  has_many :lessons, dependent: :destroy, inverse_of: :user
  has_many :scores, dependent: :destroy
  has_many :writer_scores, class_name: "Score", foreign_key: :writer_id, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following
  has_many :announcements, dependent: :destroy
  accepts_nested_attributes_for :lessons, allow_destroy: true
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def feed
    following_ids = "SELECT follower_id FROM relationships
                    WHERE following_id = :user_id"
    Announcement.where("user_id IN (#{following_ids})
                    OR user_id = :user_id", user_id: self.id)
  end

  def follow(other_user)
    followings << other_user
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save! if notification.valid?
    end
  end

  def self.guest
    find_or_initialize_by(name: 'テストダンサー', email: 'guest@example.com') do |user|
    user.password = SecureRandom.urlsafe_base64
    end
  end

  PREF_NAMES = [:'',
                :hokkaido,
                :aomori,
                :iwate,
                :miyagi,
                :akita,
                :yamagata,
                :fukushima,
                :ibaraki,
                :tochigi,
                :gunma,
                :saitama,
                :chiba,
                :tokyo,
                :kanagawa,
                :niigata,
                :toyama,
                :ishikawa,
                :fukui,
                :yamanashi,
                :nagano,
                :gifu,
                :shizuoka,
                :aichi,
                :mie,
                :shiga,
                :kyoto,
                :osaka,
                :hyogo,
                :nara,
                :wakayama,
                :tottori,
                :shimane,
                :okayama,
                :hiroshima,
                :yamaguchi,
                :tokushima,
                :kagawa,
                :ehime,
                :kochi,
                :fukuoka,
                :saga,
                :nagasaki,
                :kumamoto,
                :oita,
                :miyazaki,
                :kagoshima,
                :okinawa]
  validate :require_unique_pref, on: :update
  validates :name, presence: true #空文字でないこと
  

  extend Enumerize
  enumerize :genre, in: [:'', :hiphop, :pop, :break, :waack, :lock, :tut, :jazz, :freestyle]
  enumerize :pref1, in: PREF_NAMES
  enumerize :pref2, in: PREF_NAMES
  enumerize :pref3, in: PREF_NAMES

  def require_unique_pref
    if pref1 == pref2 || pref1 == pref3 || pref2 == pref3
       errors.add(:pref1, '地域が重複しています')
    end 
  end

end
