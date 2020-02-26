require 'rails_helper'

feature 'User can fill form for answer on questions page', %q{
  In order to reply answer on question
  As an User
  I want to fill form of the new answer on question page
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Non-authenticated user try to fill form to answer on question page' do
      visit question_path(question)
      fill_in 'Body', with: "some answer"
      click_on 'Create Answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Authenticated user try to fill form to answer on question page', js: true do
      sign_in(user)

      visit question_path(question)
      fill_in 'Body', with: "some answer"
      click_on 'Create Answer'

      expect(current_path).to eq question_path(question)
      within '.answers' do
        expect(page).to have_content 'some answer'
      end
  end

 scenario 'Authenticated user try to fill form to invalid answer on question page', js: true do
      sign_in(user)

      visit question_path(question)
      fill_in 'Body', with: ""

      click_on 'Create Answer'

      expect(page).to have_content "Body can't be blank"
  end
end
