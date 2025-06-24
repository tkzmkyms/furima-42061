# テーブル設計

## フリマアプリの主要機能

- ユーザー情報--ユーザーが登録・ログインできる
- 商品情報-----商品を出品・編集できる
- 購入記録-----購入履歴を管理する
- 配送先情報----配送先情報を登録する
- 画像保存-----商品画像をアップロードできる

## usersテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| nickname             | string     | null: false                    |
| email                | string     | null: false , unique: true     |
| encrypted_password   | string     | null: false                    |
| first_name           | string     | null: false                    |
| last_name            | string     | null: false                    |
| birthday             | date       | null: false                    |

### Association
- has_many :products
- has_many :orders

## productsテーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| name                   | string     | null: false                    |
| description            | text       | null: false                    |
| price                  | integer    | null: false                    |
| user_id                | references | null: false, foreign_key: true |
| status_id              | integer    | null: false                    |
| shipping_fee_status_id | integer    | null: false                    |
| prefecture_id          | integer    | null: false                    |
| scheduled_delivery_id  | integer    | null: false                    |



### Association
- belongs_to : user
- has_one : order

## ordersテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user_id       | references | null: false, foreign_key: true |
| product_id    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :product
- has_one :address

## addressesテーブル

| Column       | Type       | Options                        |
| -------------| ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefecture_id| integer    | null: false                    |
| city         | string     | null: false                    |
| address      | string     | null: false                    |
| building     | string     |                                |
| phone_number | string     | null: false                    |
| order_id     | references | null: false, foreign_key: true |


### Association
