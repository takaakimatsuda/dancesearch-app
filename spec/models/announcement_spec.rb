require 'rails_helper'

RSpec.describe Announcement, type: :model do
  let(:announcement) { create(:announcement) }
  let(:other_announcement) { create(:announcement) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過した場合' do
      it '有効となる' do
        expect(announcement).to be_valid
      end
    end

    context 'user_idがない場合' do
      it '無効となる' do
        announcement.user_id = nil
        expect(announcement.valid?).to be_falsey
      end
    end

    context 'アナウンスメントが空の場合' do
      it '無効となる' do
        announcement.content = nil
        expect(announcement.valid?).to be_falsey
      end
    end

    context 'アナウンスメント内容が140文字を超えた場合' do
      it '登録ができない' do
        announcement.content = "a" * 141
        expect(announcement.valid?).to be_falsey
      end
    end

    context 'アナウンスしたユーザーが削除された場合' do
      it '無効となる' do
        announcement.save
        expect(Announcement.count).to eq(1)
        announcement.user.destroy
        expect(Announcement.count).to eq(0)
      end
    end
  end
end
