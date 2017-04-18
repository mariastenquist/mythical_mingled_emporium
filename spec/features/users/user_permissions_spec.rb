require 'rails_helper'

RSpec.feature 'User Permissions' do
  context 'a user is logged in' do
    before do
      user1, user2 = create_list(:user, 2)
      orders = create_list(:order_with_diff_totals, 4)
      @order1, @order2, @order3, @order4 = orders
      user1.orders << [@order1, @order2]
      user2.orders << [@order3, @order4]

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
    end

    scenario 'a user can only see their information' do
      visit orders_path

      within('table.orders') do
        expect(page).to have_content(@order1.id)
        expect(page).to have_content(@order1.total)
      end

      within('table.orders') do
        expect(page).to_not have_link("Order #: #{@order3.id}")
        expect(page).to_not have_content(@order3.total)
      end
    end

    scenario 'a user cannot view admin dashboard' do
      visit admin_dashboard_path

      expect(page).to have_http_status(404)
      expect(page).to have_content("The page you were looking for doesn't exis")
      expect(page).to_not have_content('Admin Dashboard')
    end
  end
end
