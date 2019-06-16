class CreatePurchasedHistories < ActiveRecord::Migration[5.2]
  def change
    # デプロイの為:options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC'を追加
    # MySQL5.6の場合ActiveRecordのstring型カラムがvarchar(255)で定義されるので、
    # utf8mb4ではインデックスのキープレフィックスが767byteを超えてしまうため
    create_table :purchased_histories, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
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
