class CreateStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :statuses do |t|

      t.timestamps
    end
  end
end
