class Topic < ApplicationRecord

  belongs_to :user
  has_many :posts
  has_one :last_post, -> {order 'number desc'}, class_name: "Post"
  validates :name, presence: true
  has_many :topic_visits

  def cached_last_post

    cache_key = "cached_last_post|#{id}|#{self.updated_at}"
    Rails.cache.fetch(cache_key, expires_in: 2.days) do

      last_post  

    end
  end

  def cached_post_count

    cache_key = "cached_post_count|#{id}|#{self.updated_at}"
    Rails.cache.fetch(cache_key, expires_in: 2.days) do

      posts.size  

    end
  end

  def recent_visit(user)

    self.topic_visits.order(:created_at).where(user_id: user).last

  end

end
