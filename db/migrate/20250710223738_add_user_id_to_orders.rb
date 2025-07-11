class AddUserIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :user_id, :bigint, null: false
  end
end
