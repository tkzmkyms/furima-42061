FactoryBot.define do
  factory :user do
    nickname              { 'テストユーザー' }
    email                 { Faker::Internet.unique.email }
    password              { 'a1b2c3d4' }
    password_confirmation { password }
    first_name            { '太郎' }
    last_name             { '山田' }
    first_name_kana       { 'タロウ' }
    last_name_kana        { 'ヤマダ' }
    birthday              { '1990-01-01' }
  end
end
