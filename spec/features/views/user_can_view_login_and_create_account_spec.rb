require 'rails_helper'

RSpec.feature 'Visitor can view login page and create account' do
  context 'User is a visitor' do
    scenario 'User can view a login form page' do
      visit root_path

      within 'main' do
        click_on 'Login'
      end

      expect(current_path).to eq login_path
      expect(page).to have_field('session[username]')
      expect(page).to have_field('session[password]')
      expect(page).to have_button('Login')
    end
  end

  context 'Account creation' do
    scenario 'User enters valid credentials' do
      visit login_path

      click_on 'Create Account'

      fill_in 'user[username]', with: 'Billybob'
      fill_in 'user[email]', with: 'billybob@bbc.com'
      fill_in 'user[password]', with: 'hunter2'
      fill_in 'user[password_confirmation]', with: 'hunter2'
      click_on 'Sign Up!'

      expect(current_path).to eq dashboard_path
      within('div.nav-wrapper') do
        expect(page).to have_link('Billybobface')
      end

      within('div.profile-info') do
        expect(page).to have_content('Username: Billybob')
        expect(page).to have_content('Email: billybob@bbc.com')
      end
      expect(page).to_not have_link('Login')
      expect(page).to have_link('Logout')
    end

    scenario 'User enters invalid credentials' do
      visit login_path

      click_on 'Create Account'

      expect(current_path).to eq new_user_path

      fill_in 'user[username]', with: 'Billybob'
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: 'hunter2'
      fill_in 'user[password_confirmation]', with: 'hunter2'

      click_on 'Sign Up!'

      expect(current_path).to eq new_user_path

      within('div.flash') do
        expect(page).to have_content 'Account creation failed'
      end
    end
  end
end
