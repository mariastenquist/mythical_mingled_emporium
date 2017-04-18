require 'rails_helper'

RSpec.feature 'User can visit a landing page' do
  context 'The user is not logged in' do
    scenario 'The user visits the root path' do
      visit root_path

      within 'h1' do
        expect(page).to have_content 'Welcome!'
      end
      expect(page).to have_button 'Shop'
      expect(page).to have_button 'Login'
      expect(page).to have_link 'Create account'
    end
  end

  context 'The user is logged in' do
    scenario 'The user visits the root path' do
      user = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      within 'h1' do
        expect(page).to have_content "Welcome, #{user.username}!"
      end

      expect(page).to have_button 'Shop'
      expect(page).to_not have_button 'Login'
      expect(page).to_not have_link 'Create account'
    end
  end
end
