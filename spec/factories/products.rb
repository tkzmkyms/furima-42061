# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    name { 'テスト商品' }
    description { 'テスト用の商品説明' }
    price { 1000 }
    category_id { 2 }
    status_id { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }

    association :user

    after(:build) do |product|
      product.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
