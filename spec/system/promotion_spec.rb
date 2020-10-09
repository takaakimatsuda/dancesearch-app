require 'rails_helper'

RSpec.describe "Promotions", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  
  describe 'プロモーションの投稿のテスト' do

    before do
      log_in_as(user)
      visit user_path(other_user)
    end
    
    context '正しく入力してプロモーションを投稿した場合' do
      
      it 'プロモーションがダンサー詳細ページに表示される' do
        expect(page).to_not have_content 'これはプロモーションテストです。'
        expect do
          fill_in 'promotion[content]', with: 'これはプロモーションテストです。'
          click_button '投稿する'
        end.to change {Promotion.count}.by(+1)
        expect(page).to have_content 'これはプロモーションテストです。'
        expect(page).to have_content user.name
        expect(page).to have_content 'プロモーションを入力しました。'
      end

    end

    context '無効な内容でプロモーションを投稿した場合' do
      
      it 'プロモーション投稿に失敗する' do
        expect(page).to_not have_content 'これはプロモーションテストです。'
        expect do
          click_button '投稿する'
        end.to change {Promotion.count}.by(0)
        expect(page).to have_content 'プロモーションが空か、500文字を超えています。'
      end
      
    end
  end

  describe 'プロモーションの削除のテスト' do

    before do
      log_in_as(user)
      visit user_path(other_user)
      fill_in 'promotion[content]', with: 'これはプロモーションテストです。'
      click_button '投稿'
    end

    context '自分の投稿の場合' do
      it '削除ができる' do
        expect do
          find('.trash').click
          expect(page).to_not have_content 'これはプロモーションテストです。'
        end.to change {Promotion.count}.by(-1)
      end
    end

    context '自分以外の投稿の場合' do
      it '削除ができる' do
        log_out
        log_in_as(other_user)
        visit user_path(other_user)
        expect(page).to have_selector '.trash'
      end
    end
  end
end