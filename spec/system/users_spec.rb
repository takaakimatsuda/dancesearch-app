require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'ユーザー一覧のテスト' do   

    before do
      create_list(:user, 31)
      create(:user, name: "検索用テストユーザー")
      visit users_path
    end

    context '一般ユーザーの場合' do
      
      it 'ユーザー一覧ページが表示される' do
        expect(page).to have_title '検索一覧 | ダンサーチ！'
        expect(page).to have_selector '.pagination'
        User.all.page(1).per(20).each do |user|
          expect(page).to have_link user.name, href: user_path(user)
          expect(page).not_to have_link '削除', href: user_path(user)
        end
      end
    end
  end

  describe 'ユーザーの新規登録のテスト' do

    before do
      visit root_path
      find('.btn.btn-warning.registration-button.w-40.mb-5').click
    end

    it '新規登録ページが正しく表示される' do
      expect(page).to have_content '新規登録'
    end
    
    context '入力内容が正しいユーザーの場合' do
      it '正常に登録ができる' do
        expect do
          fill_in 'ダンサーネーム（必須）', with: '新規テストユーザー'
          fill_in 'メールアドレス（必須）', with: 'test@example.com'
          fill_in 'パスワード（必須）', with: 'password'
          fill_in 'パスワード（再確認）', with: 'password'
          click_on '登録'
        end.to change {User.count}.by(+1)
        expect(page).to have_content 'アカウント登録が完了しました。'
        expect(page).to have_content '新規テストユーザー'
      end
    end

    context '入力内容が無効なユーザーの場合' do
      it '登録失敗となる' do                
        expect do
          fill_in 'ダンサーネーム（必須）', with: '新規テストユーザー'
          fill_in 'メールアドレス（必須）', with: 'test@example.com'
          fill_in 'パスワード（必須）', with: 'password'
          fill_in 'パスワード（再確認）', with: 'invalid_password'
          click_on '登録'
        end.to change {User.count}.by(0)
        expect(page).to have_content 'パスワードが一致しません。'
      end
    end
  end

  describe 'ユーザーの編集のテスト' do

    before do
      log_in_as(user)
      visit announcements_path(user)
      click_on 'アカウント編集'
    end

    it 'プロフィール編集ページが正しく表示される' do
      expect(page).to have_title 'ユーザー編集 | ダンサーチ！'
      expect(page).to have_field 'ダンサーネーム(必須)', with: user.name
      expect(page).to have_field 'メールアドレス(必須)', with: user.email
    end

    context '有効な入力内容の場合' do
      it '正常に更新ができる' do
        user.avatar = fixture_file_upload("/files/test_image.jpg")
        fill_in '実績', with: '優勝経験あり'
        fill_in 'レッスン紹介', with: '初心者向けのレッスンです'
        fill_in 'メールアドレス', with: 'Etest@example.com'
        fill_in '現在のパスワード', with: 'password'
        click_button '更新する'
        expect(user.avatar).to be_valid
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(page).to have_content '優勝経験あり'
        expect(page).to have_content '初心者向けのレッスンです'
      end
    end

    context '無効な入力内容の場合' do
      context 'ユーザー名とメールアドレスが空欄の場合' do
        it '更新失敗となる' do
          fill_in '実績', with: '優勝経験あり'
          fill_in 'レッスン紹介', with: '初心者向けのレッスンです'
          fill_in 'ダンサーネーム(必須)', with: ''
          fill_in 'メールアドレス(必須)', with: ''
          fill_in '現在のパスワード', with: 'password'
          click_button '更新する'
          expect(page).to have_content '入力は必須です'
        end
      end
    end

      context '現在のパスワードが一致しない場合' do
        it '更新失敗となる' do
          fill_in '実績', with: '優勝経験あり'
          fill_in 'レッスン紹介', with: '初心者向けのレッスンです'
          fill_in 'ダンサーネーム(必須)', with: ''
          fill_in 'メールアドレス(必須)', with: ''
          fill_in '現在のパスワード', with: 'invalidpassword'
          click_button '更新する'
          expect(page).to have_content '現在のパスワードが違います。'
        end
      end

    context 'ログアウトしている状態でプロフィールを編集しようとした場合' do
      it 'ログインページに誘導される' do
        log_out
        visit announcements_path(user)
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end
end
