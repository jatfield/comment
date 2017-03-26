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

     get_chain(self)

  end

  def self.search(search_term)

    search_term.blank? ? all : where("to_tsvector ('hungarian', full_text) @@ to_tsquery ('hungarian', ?)", "#{search_term.split.join(" & ")}").order(created_at: :desc)

  end

  private

  def get_chain(post, chain = [])

    return chain unless post.answer_to
    chain << post.answer_to
    get_chain(post.answer_to, chain)
  
  end

end
