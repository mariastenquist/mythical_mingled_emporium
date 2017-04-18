require 'rails_helper'

RSpec.feature 'Admin orders' do
  context 'As an admin, and there are existing orders' do
    attr_reader :admin, :orders

    before do
      @admin = create :user, role: 1
      @orders = create_list :order, 10
      orders[4..6].each(&:paid!)
      orders[7..8].each(&:cancelled!)
      orders[9].completed!

      visit login_path

      fill_in 'session[username]', with: admin.username
      fill_in 'session[password]', with: admin.password

      within 'main' do
        click_on 'Login'
      end

      expect(current_path).to eq admin_dashboard_path

      within '.admin-dashboard' do
        click_on 'Orders'
      end

      expect(current_path).to eq admin_orders_path
    end

    scenario 'Admin views all orders' do
      expect(page).to have_link("Order #: #{orders.first.id}")
    end

    scenario 'See total number of orders for each status' do
      expect(page).to have_content('Ordered: 4')
      expect(page).to have_content('Paid: 3')
      expect(page).to have_content('Cancelled: 2')
      expect(page).to have_content('Completed: 1')
    end

    scenario 'Filter orders by status type' do
      within('.filters') do
        click_on 'Paid'
      end

      expect(page).to have_link("Order #: #{orders[4].id}")
      expect(page).to_not have_link("Order #: #{orders[0].id}")

      within('.filters') do
        click_on 'Cancelled'
      end

      expect(page).to have_link("Order #: #{orders[8].id}")
      expect(page).to_not have_link("Order #: #{orders[4].id}")

      within('.filters') do
        click_on 'Completed'
      end

      expect(page).to have_link("Order #: #{orders[9].id}")
      expect(page).to_not have_link("Order #: #{orders[8].id}")

    within('.filters') do
        click_on 'All'
      end

      expect(page).to have_link("Order #: #{orders[9].id}")
      expect(page).to have_link("Order #: #{orders[8].id}")
      expect(page).to have_link("Order #: #{orders[6].id}")
      expect(page).to have_link("Order #: #{orders[3].id}")
    end

    scenario 'Update order status through links' do
      within "tr#order-#{orders[1].id}" do
        expect(page).to have_link 'Cancel'
        expect(page).to have_content 'Status: Ordered'

        click_on 'Mark as paid'
      end

      expect(current_path).to eq admin_orders_path

      within "tr#order-#{orders[1].id}" do
        expect(page).to have_content 'Status: Paid'
      end

      within "tr#order-#{orders[2].id}" do
        click_on 'Cancel'
      end
        expect(current_path).to eq admin_orders_path

      within "tr#order-#{orders[2].id}" do
        expect(page).to have_content 'Status: Cancelled'
      end

      within "tr#order-#{orders[4].id}" do
        expect(page).to have_link 'Cancel'
        expect(page).to have_content 'Status: Paid'

        click_on 'Mark as completed'
      end

      expect(current_path).to eq admin_orders_path

      within "tr#order-#{orders[4].id}" do
        expect(page).to have_content 'Status: Completed'
      end

      within "tr#order-#{orders[5].id}" do
        click_on 'Cancel'
      end
        expect(current_path).to eq admin_orders_path

      within "tr#order-#{orders[5].id}" do
        expect(page).to have_content 'Status: Cancelled'
      end

      within "tr#order-#{orders[7].id}" do
        expect(page).to_not have_link 'Cancel'
        expect(page).to_not have_link 'Mark as completed'
      end

      within "tr#order-#{orders[9].id}" do
        expect(page).to_not have_link 'Cancel'
        expect(page).to_not have_link 'Mark as completed'
      end
    end
  end
end
