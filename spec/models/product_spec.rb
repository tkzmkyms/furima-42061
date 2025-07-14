require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe 'Product listing feature' do
    context 'when listing is possible' do
      it 'is valid with all required attributes correctly filled' do
        expect(@product).to be_valid
      end
    end

    context 'when listing is not possible' do
      it 'is invalid without a name' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

      it 'is invalid without a description' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end

      it 'is invalid without a price' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it 'is invalid if price is less than 300' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not included in the list')
      end

      it 'is invalid if price is greater than 9,999,999' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not included in the list')
      end

      it 'is invalid if price contains non-half-width digits (full-width digits)' do
        @product.price = '１０００'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end

      it 'is invalid if category_id is 1 (unselected)' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Category must be other than 1')
      end

      it 'is invalid if status_id is 1 (unselected)' do
        @product.status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Status must be other than 1')
      end

      it 'is invalid if shipping_fee_status_id is 1 (unselected)' do
        @product.shipping_fee_status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Shipping fee status must be other than 1')
      end

      it 'is invalid if prefecture_id is 1 (unselected)' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it 'is invalid if scheduled_delivery_id is 1 (unselected)' do
        @product.scheduled_delivery_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Scheduled delivery must be other than 1')
      end

      it 'is invalid without an attached image' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end

      it 'is invalid without an associated user' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('User must exist')
      end
    end
  end
end
