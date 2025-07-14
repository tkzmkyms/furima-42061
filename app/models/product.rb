class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  # 必須項目のバリデーション
  validates :name, :description, :price, presence: true

  # ActiveHash：idが1（---）のままでは登録不可にする
  validates :category_id, :status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
            numericality: { other_than: 1 }

  # 金額のバリデーション：300〜9,999,999の半角数字
  validates :price,
            numericality: { only_integer: true },
            inclusion: { in: 300..9_999_999 }

  # ActiveStorage：画像添付の有無チェック
  validate :image_presence

  private

  def image_presence
    errors.add(:image, "can't be blank") unless image.attached?
  end
end
