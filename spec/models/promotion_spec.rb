require 'rails_helper'

RSpec.describe Promotion, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'プロモーション入力のバリデーションテスト' do
    
    context 'プロモーションコメントが正しい場合' do
      it '正常に登録できる' do
        promotion = user.promotions.build(
        content: 'これはプロモーションテストです。',
        )
        promotion.writer = other_user
        promotion.save
        expect(promotion).to be_valid
      end
    end

    context 'プロモーションコメントが空の場合' do
      it '無効となる' do
        promotion = user.promotions.build(
          content: nil,
        )
        promotion.writer = other_user
        promotion.save
        expect(promotion.valid?).to be_falsey
      end
    end

    context 'プロモーションコメントが500文字より多い場合' do
      it '無効となる' do
        promotion = user.promotions.build(
          content: "a" * 501,
        )
        promotion.writer = other_user
        promotion.save
        expect(promotion.valid?).to be_falsey
      end
    end

    context 'writer_idがnilの場合' do
      it '無効となる' do
        promotion = user.promotions.build(
          content: 'これはプロモーションテストです。',
        )
        promotion.writer = nil
        promotion.save
        expect(promotion.valid?).to be_falsey
      end
    end

    context 'プロモーションしたユーザーが削除された場合' do
      it '無効となる' do
        promotion = user.promotions.build(
          content: 'これはプロモーションテストです。',
          )
        promotion.writer = other_user
        promotion.save
        expect(Promotion.count).to eq(1)
        promotion.user.destroy
        expect(Promotion.count).to eq(0)
      end
    end
  end
end
