json.extract! item, :id, :item_name, :item_description, :item_image_id, :item_qr, :item_price, :item_active, :created_at, :updated_at
json.url item_url(item, format: :json)
