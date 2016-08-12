json.extract! upload, :id, :user_id, :post_id, :created_at, :updated_at
json.url upload_url(upload, format: :json)