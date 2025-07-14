class ChangeUserIdNullConstraintOnOrders < ActiveRecord::Migration[7.1]
  def change
    # ordersテーブルのuser_idカラムを null不許容に変更
    change_column_null :orders, :user_id, false
  end
end
