require 'rails_helper'

feature 'User sign in', %q{
  In order to sign in
  As an User
  i want to be able to sign up
} do

  scenario 'Non-registered user try to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: "test@mail.com"
    fill_in 'Password', with: "11112222"
    fill_in 'Password confirmation', with: "11112222"
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Registered user try to sign in' do
    User.create(email: "test@mail.com", password: "11112222")

    visit new_user_registration_path
    fill_in 'Email', with: "test@mail.com"
    fill_in 'Password', with: "11112222"
    fill_in 'Password confirmation', with: "11112222"
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end
end
