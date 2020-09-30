require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { create(:relationship) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過した場合' do
      it '有効となる' do
        expect(relationship).to be_valid
      end
    end

    context 'follower_idがない場合' do
      it '無効となる' do
        relationship.follower_id = nil
        expect(relationship.valid?).to be_falsey
      end
    end

    context 'following_idがない場合' do
      it '無効となる' do
        relationship.following_id = nil
        expect(relationship.valid?).to be_falsey
      end
    end

    context 'フォローしているユーザーが削除された場合' do
      it '無効となる' do
        relationship.save
        expect(Relationship.count).to eq(1)
        relationship.follower.destroy
        expect(Relationship.count).to eq(0)
      end
    end

    context 'フォローされているユーザーが削除された場合' do
      it '無効となる' do
        relationship.save
        expect(Relationship.count).to eq(1)
        relationship.following.destroy
        expect(Relationship.count).to eq(0)
      end
    end
  end
end
