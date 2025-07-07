class CreateScheduledDeliveries < ActiveRecord::Migration[7.1]
  def change
    create_table :scheduled_deliveries do |t|

      t.timestamps
    end
  end
end
