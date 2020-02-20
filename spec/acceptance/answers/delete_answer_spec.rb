require 'rails_helper'

feature 'User can delete his own answer' do
  given(:user1) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, author: user1) }
  given!(:answer) { create(:answer, question_id: question.id, author: user1) }

  scenario 'user1 try to delete user1 answer' do
    sign_in(user1)

    visit question_path(question)
    click_on 'Delete'

    expect(page).to have_content "you successfully deleted"
    expect(page).to have_no_content answer.body
  end

  scenario 'user2 try to delete user1 answer' do
    sign_in(user2)

    visit question_path(question)

    expect(page).to have_no_content "Delete"
    expect(page).to have_content answer.body
  end

  scenario "Unauthenticated user can't delete answer" do
    visit question_path(question)

    expect(page).to have_no_content "Delete"
    expect(page).to have_content answer.body
  end
end
