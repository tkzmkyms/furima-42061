require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
    sleep 0.1 # DBが重なるのを防止するため
    @order_address = OrderAddress.new(
      user_id: @user.id,
      product_id: @product.id,
      token: 'tok_abcdefghijk00000000000000000',
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '横浜市',
      address: '青山1-1-1',
      building: '柳ビル103',
      phone_number: '09012345678'
    )
  end

  context '内容に問題がない場合' do
    it 'すべての値が正しく入力されていれば保存できる' do
      expect(@order_address).to be_valid
    end

    it '建物名が空でも保存できる' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'tokenが空では保存できない' do
      @order_address.token = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('クレジットカード情報を入力してください')
    end

    it '郵便番号が空では保存できない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('郵便番号を入力してください')
    end

    it '郵便番号にハイフンがないと保存できない' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('郵便番号は「3桁-4桁」の形式で入力してください')
    end

    it '都道府県が「0」では保存できない' do
      @order_address.prefecture_id = 0
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('都道府県を選択してください')
    end

    it '市区町村が空では保存できない' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('市区町村を入力してください')
    end

    it '番地が空では保存できない' do
      @order_address.address = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('番地を入力してください')
    end

    it '電話番号が空では保存できない' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('電話番号を入力してください')
    end

    it '電話番号にハイフンがあると保存できない' do
      @order_address.phone_number = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('電話番号は10〜11桁の半角数字で入力してください')
    end

    it '電話番号が12桁以上だと保存できない' do
      @order_address.phone_number = '090123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('電話番号は10〜11桁の半角数字で入力してください')
    end

    it 'userが紐付いていないと保存できない' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Userを入力してください')
    end

    it 'productが紐付いていないと保存できない' do
      @order_address.product_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Productを入力してください')
    end
  end
end
