require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { create(:notification) }

  describe 'バリデーションのテスト' do

    context 'カラムの値が有効な場合' do
      it '有効となる' do
        p notification.inspect
        expect(notification).to be_valid
      end
    end

    context 'visitor_idがない場合' do
      it '無効となる' do
        notification.visitor_id = nil
        expect(notification.valid?).to be_falsey
      end
    end

    context 'visited_idがない場合' do
      it '無効となる' do
        notification.visited_id = nil
        expect(notification.valid?).to be_falsey
      end
    end
  end
end
