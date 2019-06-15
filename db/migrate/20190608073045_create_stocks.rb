class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :item_id
      t.integer :stock_count

      t.timestamps
    end
  end
end
