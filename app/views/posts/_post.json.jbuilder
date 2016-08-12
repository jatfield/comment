json.extract! post, :id, :full_text, :user_id, :number, :topic_id, :answer_to_id, :created_at, :updated_at
json.url post_url(post, format: :json)