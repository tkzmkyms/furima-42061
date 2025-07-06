class CreateShippingFeeStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_fee_statuses do |t|

      t.timestamps
    end
  end
end
