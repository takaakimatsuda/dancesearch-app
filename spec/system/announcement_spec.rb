require 'rails_helper'

RSpec.describe "Announcements", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  
  describe 'アナウンスの投稿のテスト' do

    before do
      log_in_as(user)
      visit announcements_path
    end
    
    context '正しく入力してアナウンスを投稿した場合' do
      
      it 'アナウンスがアナウンス一覧ページに表示される' do
        expect(page).to_not have_content 'これはアナウンステストです。'
        expect do
          fill_in 'announcement[content]', with: 'これはアナウンステストです。'
          click_button 'アナウンスする'
        end.to change {Announcement.count}.by(+1)
        expect(page).to have_content 'これはアナウンステストです。'
        expect(page).to have_content user.name
        expect(page).to have_content 'アナウンスを入力しました。'
      end

      it 'アナウンスがマイアナウンスページに表示される' do
        expect(page).to_not have_content 'これはアナウンステストです。'
        expect do
          fill_in 'announcement[content]', with: 'これはアナウンステストです。'
          click_button 'アナウンスする'
          visit announcement_path(user)
        end.to change {Announcement.count}.by(+1)
        expect(page).to have_content 'これはアナウンステストです。'
        expect(page).to have_content user.name
      end

    end

    context '無効な内容でアナウンスを投稿した場合' do
      
      it 'アナウンス投稿に失敗する' do
        expect(page).to_not have_content 'これはアナウンステストです。'
        expect do
          click_button 'アナウンスする'
        end.to change {Announcement.count}.by(0)
        expect(page).to have_content 'アナウンスが空か、140文字を超えています。'
      end
      
    end
  end

  describe 'アナウンスの削除のテスト' do

    before do
      log_in_as(user)
      visit announcements_path
      fill_in 'announcement[content]', with: 'これはアナウンステストです。'
      click_button 'アナウンスする'
    end

    context '自分の投稿の場合' do
      it '削除ができる' do
        expect do
          find(".trash#{Announcement.first.id}").click
          expect(page).to_not have_content 'これはアナウンステストです。'
        end.to change {Announcement.count}.by(-1)
      end
    end

    context '自分以外の投稿の場合' do
      it '削除ボタンが表示されない' do
        log_out
        log_in_as(other_user)
        visit announcements_path
        expect do
          fill_in 'announcement[content]', with: 'これはアナウンステストです。'
          click_button 'アナウンスする'
        end.to change {Announcement.count}.by(+1)
        log_out
        log_in_as(user)
        visit announcements_path
        expect(page).to_not have_selector ".trash#{Announcement.first.id}"
      end
    end
  end
end