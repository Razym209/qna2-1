require 'rails_helper'

feature 'User sign out', %q{
  In order to be able to end session
  As an User
  i want to be able to sign out
} do

given(:user) { create(:user) }

  scenario 'log in user try to sign out' do
    sign_in(user)
    sign_out

    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_content 'log_in'
  end

  scenario 'Non log in user try to log out' do
    visit "/"

    expect(page).to have_no_content 'log_out'
  end
end
