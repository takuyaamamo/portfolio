class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_name
      t.text :item_description
      t.string :item_image_id
      t.string :item_qr
      t.integer :item_price
      t.integer :item_active

      t.timestamps
    end
  end
end
