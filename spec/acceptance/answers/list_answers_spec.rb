require 'rails_helper'

feature 'Users can see answers list', %q{
  In order to see answers
  As an Non-authenticated user
  I want to see answers
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answers) { create_list(:generate_answer, 4, question_id: question.id) }

  scenario 'authenticated user see answers' do
    sign_in(user)

    visit question_path(question)

    answers.each do |question|
      expect(page).to have_content question.body
    end
  end

  scenario 'Non-authenticated user see answers' do
    visit question_path(question)

    answers.each do |question|
      expect(page).to have_content question.body
    end
  end
end
