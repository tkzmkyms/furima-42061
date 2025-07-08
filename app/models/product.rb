class Product < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image

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
            numericality: { other_than: 1, message: 'を選択してください' }

  # 金額のバリデーション：300〜9,999,999の半角数字
  validates :price,
            numericality: { only_integer: true, message: 'は半角数字で入力してください' },
            inclusion: { in: 300..9_999_999, message: 'は¥300〜¥9,999,999の間で入力してください' }

  # ActiveStorage：画像添付の有無チェック
  validate :image_presence

  private

  def image_presence
    errors.add(:image, 'を添付してください') unless image.attached?
  end
end
