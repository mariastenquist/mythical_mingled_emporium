require 'rails_helper'

RSpec.feature 'Unauthenticated user permissions' do
  context 'a user is not logged in' do
    before do
      user1 = create(:user)
      @order1, @order2, @order3, @order4 = create_list(:order, 4)
      user1.orders << [@order1, @order2]
    end

    scenario 'so she cannot access orders' do
      visit orders_path

      expect(current_path).to eq login_path
      within 'div.flash' do
        expect(page).to have_content 'Oops! You must be logged in to do that.'
      end
    end

    scenario 'so she cannot see a dashboard' do
      visit dashboard_path

      expect(current_path).to eq login_path
      within 'div.flash' do
        expect(page).to have_content 'Oops! You must be logged in to do that.'
      end
    end

    scenario 'a user cannot view admin dashboard' do
      visit admin_dashboard_path

      expect(page).to have_http_status(404)
      expect(page).to_not have_content('Admin Dashboard')
    end

    scenario 'will be redirected to login/create account when they checkout' do
      visit cart_path

      expect(page).to_not have_button 'Checkout'
      expect(page).to have_content('Login or Create Account to Checkout')
    end
  end
end
