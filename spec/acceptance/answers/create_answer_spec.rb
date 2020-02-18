require 'rails_helper'

feature 'User can fill form for answer on questions page', %q{
  In order to reply answer on question
  As an User
  I want to fill form of the new answer on question page
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:invalid_answer) { create(:invalid_answer, question_id: question.id) }

  scenario 'Non-authenticated user try to fill form to answer on question page' do
      visit question_path(question)
      fill_in 'Body', with: "some answer"
      click_on 'Create Answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Authenticated user try to fill form to answer on question page' do
      sign_in(user)

      visit question_path(question)
      fill_in 'Body', with: "some answer"
      click_on 'Create Answer'

      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'some answer'
  end

  scenario 'Authenticated user try to fill form to invalid answer on question page' do
      sign_in(user)

      visit question_path(question)
      fill_in 'Body', with: ""
      click_on 'Create Answer'

      expect(page).to have_content "Body can't be blank"
  end
end
