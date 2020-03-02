class Answer < ApplicationRecord
  
  default_scope { order(best: :desc).order(created_at: :asc) }
  belongs_to :question
  belongs_to :author, class_name: "User"

  has_many_attached :files
  
  validates :body, presence: true

  def select_best
    Answer.transaction do
      question.answers.where(best: true).update_all(best: false)
      update!(best: true)
    end
  end
end
