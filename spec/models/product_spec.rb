require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品出品機能' do
    context '出品できる場合' do
      it 'すべての項目が正しく入力されていれば保存できる' do
        expect(@product).to be_valid
      end
    end

    context '出品できない場合' do
      it 'nameが空では保存できない' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('Nameを入力してください')
      end

      it 'descriptionが空では保存できない' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('Descriptionを入力してください')
      end

      it 'priceが空では保存できない' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('Priceを入力してください')
      end

      it 'priceが299以下では保存できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include('Priceは¥300〜¥9,999,999の間で入力してください')
      end

      it 'priceが10000000以上では保存できない' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('Priceは¥300〜¥9,999,999の間で入力してください')
      end

      it 'priceが半角数字以外では保存できない（全角数字）' do
        @product.price = '１０００'
        @product.valid?
        expect(@product.errors.full_messages).to include('Priceは半角数字で入力してください')
      end

      it 'category_idが1では保存できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Categoryを選択してください')
      end

      it 'status_idが1では保存できない' do
        @product.status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Statusを選択してください')
      end

      it 'shipping_fee_status_idが1では保存できない' do
        @product.shipping_fee_status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Shipping fee statusを選択してください')
      end

      it 'prefecture_idが1では保存できない' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Prefectureを選択してください')
      end

      it 'scheduled_delivery_idが1では保存できない' do
        @product.scheduled_delivery_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Scheduled deliveryを選択してください')
      end

      it 'imageが添付されていないと保存できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('Imageを添付してください')
      end

      it 'userが紐づいていないと保存できない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
