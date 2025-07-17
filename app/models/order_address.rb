class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :product_id, :token,
                :postal_code, :prefecture_id, :city, :address,
                :building, :phone_number

  # バリデーション
  with_options presence: true do
    validates :user_id
    validates :product_id
    validates :token
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  # 保存処理
  def save
    # 購入情報を保存（Orderテーブル）
    order = Order.create(user_id: user_id, product_id: product_id)

    # 発送先情報を保存（Addressテーブル）
    address = Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: self.address,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
