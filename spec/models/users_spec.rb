require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = build(:user)
  end

  describe 'バリデーション' do
    it 'nameとemailとダンサーネームの値が設定されていれば、OK' do
      expect(@user.valid?).to be_truthy
    end

    it 'nameが空だとNG' do
      @user.name = ''
      expect(@user.valid?).to be_falsey
    end

    it 'emailが空だとNG' do
      @user.email = ''
      expect(@user.valid?).to be_falsey
    end

    it 'passwordが空だとNG' do
      @user.password = ''
      expect(@user.valid?).to be_falsey
    end
  end
end