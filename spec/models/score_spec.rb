require 'rails_helper'

RSpec.describe Score, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  describe 'スコア登録のバリデーションテスト' do

    context 'スコアポイントが正しい場合' do
      it '正常に登録できる' do
        score = user.scores.build(
        point: '1',
        )
        score.writer = other_user
        score.save
        expect(score).to be_valid
      end
    end
    
    context 'スコアポイントを4回入れた場合' do
      it 'バリデーションがかかる' do
        for num in 1..3 do
          score = user.scores.build(
            point: '1',
            )
          score.writer = other_user
          score.save
        end
        score = user.scores.build(
          point: '1',
          )
        score.writer = other_user
        score.save
        user.valid?
        expect(score.errors[:point]).to include('の入力は1日３回までです')
      end
    end
  end
end
