json.extract! posts_per_page, :id, :value, :created_at, :updated_at
json.url posts_per_page_url(posts_per_page, format: :json)