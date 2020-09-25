require 'rails_helper'

RSpec.describe Score, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'スコア登録のバリデーションテスト' do

    context 'スコアポイントが正しい場合' do
      it '正常に登録できる' do
        other_user.writer_scores = user.scores.build(
          point: '1',
        )
        expect(writer_scores).to be_valid
      end
    end
  end
end
