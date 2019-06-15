json.extract! purchased_history, :id, :user_name, :postal_code, :address, :phone_number, :email_address, :shipping, :created_at, :updated_at, :created_at, :updated_at
json.url purchased_history_url(purchased_history, format: :json)
