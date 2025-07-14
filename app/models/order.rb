class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :address, dependent: :destroy

  validates :user, presence: true
end
