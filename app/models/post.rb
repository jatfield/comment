class Post < ApplicationRecord

  belongs_to :user
  belongs_to :topic, touch: true
  belongs_to :answer_to, class_name: "Post"
  has_many :answers, class_name: "Post", primary_key: "answer_to_id"
  has_many :votes
  has_many :uploads

  validates :number, uniqueness: { scope: :topic_id}  
  validates :user, :topic, :full_text, :number, presence: true

  def created_at_l

    if self.created_at.to_date === Date.today
      "Ma, #{self.created_at.strftime('%H:%M')}"
    elsif self.created_at.to_date === Date.today.advance(days: -1)
      "Tegnap, #{self.created_at.strftime('%H:%M')}"
    else
      I18n.l self.created_at
    end

  end

  def question_chain

    chain = []
    post = self
    while post.answer_to do
      chain << post.answer_to
      post = post.answer_to
    end
    return chain
  end

  def self.search(search_term)
 
    search_term.blank? ? all : where("full_text LIKE ?", "%#{search_term}%")

  end

end
