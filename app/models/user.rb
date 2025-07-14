class User < ApplicationRecord
  has_many :orders
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネーム、名前、カナ、生年月日
  with_options presence: true do
    validates :nickname
    validates :first_name,       format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :last_name,        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :first_name_kana,  format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
    validates :last_name_kana,   format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
    validates :birthday
  end

  # パスワード（6文字以上、英数字混合）
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は半角英数字混合で入力してください' },
                       if: :password_required?

  private

  def password_required?
    password.present? || password_confirmation.present?
  end
end
