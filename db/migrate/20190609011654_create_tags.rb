class CreateTags < ActiveRecord::Migration[5.2]
  def change
    # デプロイの為:options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC'を追加
    # MySQL5.6の場合ActiveRecordのstring型カラムがvarchar(255)で定義されるので、
    # utf8mb4ではインデックスのキープレフィックスが767byteを超えてしまうため
    create_table :tags, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string :tag_name

      t.timestamps
    end
  end
end
