class CreatePurchasedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :purchased_items do |t|
      t.integer :purchased_history_id
      t.integer :item_id
      t.integer :item_count

      t.timestamps
    end
  end
end
