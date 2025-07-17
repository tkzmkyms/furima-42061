class User < ApplicationRecord
  has_many :orders
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネーム、名前、カナ、生年月日
  with_options presence: true do
    validates :nickname
    validates :first_name,
              format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'must be full-width characters (Kanji, Hiragana, Katakana)' }
    validates :last_name,
              format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'must be full-width characters (Kanji, Hiragana, Katakana)' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'must be full-width Katakana characters' }
    validates :last_name_kana,  format: { with: /\A[ァ-ヶー－]+\z/, message: 'must be full-width Katakana characters' }
    validates :birthday
  end

  # パスワード（6文字以上、英数字混合）
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  validates :password,
            presence: true,
            format: { with: VALID_PASSWORD_REGEX, message: 'must include both letters and numbers' },
            if: :password_required?

  private

  def password_required?
    password.present? || password_confirmation.present?
  end
end
