require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録のバリデーション' do
    it 'メールアドレスが空だと登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールを入力してください')
    end

    it 'メールアドレスが重複していると登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it 'メールアドレスに@がないと登録できない' do
      @user.email = 'testexample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it 'パスワードが空だと登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください')
    end

    it 'パスワードが6文字未満だと登録できない' do
      @user.password = 'a1b2c'
      @user.password_confirmation = 'a1b2c'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end

    it 'パスワードと確認用パスワードが一致しないと登録できない' do
      @user.password = 'a1b2c3'
      @user.password_confirmation = 'd4e5f6'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end
  end
end
