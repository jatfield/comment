class TopicVisit < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  def self.recent_visits(user, topic)

    self.order(:created_at).where(user_id: user, topic_id: topic).last

  end

end
