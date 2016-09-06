class Post < ApplicationRecord

  belongs_to :user
  belongs_to :topic, touch: true
  belongs_to :answer_to, class_name: "Post"
  has_many :answers, class_name: "Post", primary_key: "answer_to_id"
  has_many :upvotes, -> { where downvote: false }, class_name: "Vote"
  has_many :downvotes, -> { where downvote: true }, class_name: "Vote"
  has_many :uploads

  validates :number, uniqueness: { scope: :topic_id}  
  validates :user, :topic, :full_text, :number, presence: true

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
 
    search_term.blank? ? all : where("full_text ILIKE ?", "%#{search_term}%")

  end

end
