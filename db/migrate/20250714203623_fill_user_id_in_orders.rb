class FillUserIdInOrders < ActiveRecord::Migration[7.1]
  def up
    # モデルのカラム情報をリロード（新しいuser_idカラムが認識されるように）
    Order.reset_column_information

    # user_id がまだ nil のレコードをすべて user_id: 1 に更新
    # 1 は仮のユーザーIDなので、実際の環境に合わせて変更してください
    Order.where(user_id: nil).update_all(user_id: 1)
  end

  def down
    # rollback時はすべての user_id を nil に戻す
    Order.update_all(user_id: nil)
  end
end

