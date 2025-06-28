class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.references :user, null: false, foreign_key: true
      t.integer :status_id
      t.integer :category_id
      t.integer :shipping_fee_status_id
      t.integer :prefecture_id
      t.integer :scheduled_delivery_id

      t.timestamps
    end
  end
end