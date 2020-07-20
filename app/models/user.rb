class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :avatar

  has_many :promotions, dependent: :destroy

  PREF_NAMES = [:hokkaido,
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
  enumerize :genre, in: [:hiphop, :pop, :break, :waack, :lock, :tut, :jazz, :freestyle]
  enumerize :pref1, in: PREF_NAMES
  enumerize :pref2, in: PREF_NAMES
  enumerize :pref3, in: PREF_NAMES

  def require_unique_pref
    if pref1 == pref2 || pref1 == pref3 || pref2 == pref3
       errors.add(:pref1, '地域が重複しています')
    end 
  end

end
