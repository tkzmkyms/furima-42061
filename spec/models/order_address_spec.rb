require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    puts "Current locale: #{I18n.locale}" # ← ここでロケールを出力
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
    sleep 0.1 # DBの重複登録を防ぐためのウェイト

    @order_address = FactoryBot.build(:order_address, user_id: @user.id, product_id: @product.id)
  end

  context 'when content is valid' do
    it 'is valid with all required fields correctly filled' do
      expect(@order_address).to be_valid
    end

    it 'is valid even if building name is empty' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end
  end

  context 'when content has issues' do
    it 'is invalid without token' do
      @order_address.token = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it 'is invalid without postal_code' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'is invalid if postal_code does not contain hyphen' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid')
    end

    it 'is invalid if prefecture_id is 0' do
      @order_address.prefecture_id = 0
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Prefecture must be other than 0')
    end

    it 'is invalid without city' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it 'is invalid without address' do
      @order_address.address = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Address can't be blank")
    end

    it 'is invalid without phone_number' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'is invalid if phone_number contains hyphens' do
      @order_address.phone_number = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'is invalid if phone_number contains non-digit characters' do
      @order_address.phone_number = '090abc4567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'is invalid if phone_number contains full-width digits' do
      @order_address.phone_number = '０９０１２３４５６７８' # 全角数字
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'is invalid if phone_number is longer than 11 digits' do
      @order_address.phone_number = '090123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'is invalid if phone_number is shorter than 10 digits' do
      @order_address.phone_number = '090123456'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'is invalid without associated user' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it 'is invalid without associated product' do
      @order_address.product_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Product can't be blank")
    end
  end
end
