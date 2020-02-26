class AddAuthorIdInQuestions < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :questions, :author
  end
end
