class CreatePurchasedHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :purchased_histories do |t|
      t.string :user_name
      t.string :postal_code
      t.string :address
      t.string :phone_number
      t.string :email_address
      t.integer :shipping
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
