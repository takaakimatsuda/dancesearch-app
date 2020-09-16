class Score < ApplicationRecord
  belongs_to :user
  belongs_to :writer, class_name: 'User', foreign_key: :writer_id
  validates :point, presence: true
  validate :check_day_count_of_scores

  def check_day_count_of_scores
    #一日のスコアポイントを入れた数が3回を超えた場合
    if writer.writer_scores.where(created_at: Date.current.all_day).count >= 3
      errors.add(:point, 'の入力は1日３回までです')
    end
  end

  ransacker :scores_point do
    query = 'SELECT SUM(point) FROM scores GROUP BY scores.user_id'
    Arel.sql(query)
  end
end
