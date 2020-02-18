require 'rails_helper'

feature 'Users can see questions list', %q{
  In order to see questions
  As an Non-authenticated user
  I want to see questions
} do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:generate_question, 4) }

  scenario 'authenticated user see questions' do
    sign_in(user)

    visit questions_path

    questions.each do |question|
      expect(page).to have_content question.title
    end
  end

  scenario 'Non-authenticated user see questions' do
    visit questions_path

    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end
