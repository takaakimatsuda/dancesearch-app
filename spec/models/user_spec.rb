require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'ユーザー登録のバリデーションテスト' do

    context '必須のカラムがすべて正しい場合' do
      it '正常に登録できる' do
        expect(user).to be_valid
      end
    end
    
    context 'ネームが空の場合' do
      it '登録できない' do
        user.name = ''
        expect(user.valid?).to be_falsey
        expect(user.errors[:name]).to include('入力は必須です。')
      end
    end

    context 'メールアドレスが空の場合' do
      it '登録できない' do
        user.email = ''
        expect(user.valid?).to be_falsey
        expect(user.errors[:email]).to include('入力は必須です。')
      end
    end

    context 'メールアドレスのフォーマットが有効でない場合' do
      it '登録ができない' do
        user.email = 'testexample.com'
        expect(user.valid?).to be_falsey
        expect(user.errors[:email]).to include('は有効でありません。')
      end
    end

    context 'メールアドレスが一意でない場合' do
      it '登録ができない' do
        user.save
        other_user.email = user.email
        expect(other_user.valid?).to be_falsey
        expect(other_user.errors[:email]).to include('は既に使用されています。')
      end
    end

    context 'パスワードが空の場合' do
      it '登録できない' do
        user.password = ''
        expect(user.valid?).to be_falsey
        expect(user.errors[:password]).to include('入力は必須です。')
      end
    end

    context 'パスワードが6文字より少ない場合' do
      it '登録ができない' do
        user.password = 'a' * 5
        expect(user.valid?).to be_falsey
        expect(user.errors[:password]).to include('は6文字以上に設定して下さい。')
      end
    end

    context 'パスワードとパスワード確認が一致しない場合' do
      it '登録ができない' do
        user.password_confirmation = 'invalid_password'
        expect(user.valid?).to be_falsey
        expect(user.errors.full_messages.to_s).to include('が一致しません')
      end
    end
  end

  describe 'ユーザー詳細編集のバリデーションテスト' do

    context '地域2が重複している場合' do
      it '登録ができない' do
        user.pref2 = User.pref2.values[1]
        expect(user.valid?).to be_falsey
        expect(user.errors.full_messages.to_s).to include('地域が重複しています')
      end
    end

    context '地域3が重複している場合' do
      it '登録ができない' do
        user.pref3 = User.pref3.values[1]
        expect(user.valid?).to be_falsey
        expect(user.errors.full_messages.to_s).to include('地域が重複しています')
      end
    end
  end
end