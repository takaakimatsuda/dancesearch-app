require 'rails_helper'

RSpec.describe 'ログイン・ログアウト機能のシステムテスト', type: :system do
  let!(:user) { create(:user) }

  describe 'ログインのテスト' do
  
    before do
      visit new_user_session_path
    end
  
    it 'ログインページが正しく表示される' do
      expect(page).to have_content 'ログイン'
      expect(page).to have_link '新規登録はこちら', href: new_user_registration_path
    end
      
    context '入力内容が正しいユーザーの場合' do
      it '正常にログインできてヘッダーの項目に反映される' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'password', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content user.name
        expect(page).not_to have_link '新規登録', href: new_user_registration_path
        expect(page).not_to have_link 'ログイン', href: new_user_session_path
        find('.dropdown').click
        expect(page).to have_link 'マイプロフィール', href: user_path(user)
        expect(page).to have_link 'プロフィール編集', href: edit_user_registration_path
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
      end
    end
  
    context '入力内容が無効なユーザーの場合' do
      it 'ログイン失敗となる' do
        fill_in 'メールアドレス', with: 'invalid_test@example.com'
        fill_in 'password', with: 'invalid_password'
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
        visit root_path
        expect(page).not_to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
  end

  describe 'ログアウトのテスト' do
    it 'ログインを行うとヘッダーの項目に反映される' do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'password', with: user.password
      click_button 'ログイン'
      find('.dropdown').click
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
    end
  end
end