require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'User Registration Validations' do
    context 'when registration is successful' do
      it 'is valid with all required fields filled correctly' do
        expect(@user).to be_valid
      end

      it 'is valid when password is at least 6 characters with mixed alphanumeric characters' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
    end

    context 'when registration fails' do
      # Email validations
      it 'is invalid without an email' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'is invalid with a duplicate email address' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'is invalid without @ symbol in email' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      # Password validations
      it 'is invalid without a password' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'is invalid if password is less than 6 characters' do
        @user.password = 'a1b2c'
        @user.password_confirmation = 'a1b2c'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'is invalid if password and confirmation do not match' do
        @user.password = 'a1b2c3'
        @user.password_confirmation = 'd4e5f6'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'is invalid if password contains only letters' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end

      it 'is invalid if password contains only numbers' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end

      it 'is invalid if password contains full-width characters' do
        @user.password = 'ＡＢＣ１２３' # full-width alphanumeric
        @user.password_confirmation = 'ＡＢＣ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end

      # Nickname validations
      it 'is invalid without a nickname' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      # Full name validations (full-width characters)
      it 'is invalid without a last name' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name must be full-width characters (Kanji, Hiragana, Katakana)')
      end

      it 'is invalid without a first name' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name must be full-width characters (Kanji, Hiragana, Katakana)')
      end

      it 'is invalid if last name is not full-width' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name must be full-width characters (Kanji, Hiragana, Katakana)')
      end

      it 'is invalid if first name is not full-width' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name must be full-width characters (Kanji, Hiragana, Katakana)')
      end

      # Kana name validations (full-width Katakana)
      it 'is invalid without last name kana' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana must be full-width Katakana characters')
      end

      it 'is invalid without first name kana' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana must be full-width Katakana characters')
      end

      it 'is invalid if last name kana is not Katakana' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana must be full-width Katakana characters')
      end

      it 'is invalid if first name kana is not Katakana' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana must be full-width Katakana characters')
      end

      # Birthday validations
      it 'is invalid without a birthday' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
