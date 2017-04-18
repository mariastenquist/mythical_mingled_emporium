require 'rails_helper'

RSpec.feature 'User can view past orders' do
  context 'an exisiting user, who has orders' do
    before do
      user = create(:user)
      @order1, @order2 = create_list(:order, 2)
      @order2.cancelled!
      user.orders << [@order1, @order2]
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
    end

    scenario 'can see their dashboard with all their past orders' do
      order1_time = @order1.created_at.strftime('%b %e, %l:%M %p')
      order2_time = @order2.created_at.strftime('%b %e, %l:%M %p')
      within('table.orders') do
        within("tr#order-#{@order1.id}") do
          expect(page).to have_content(@order1.id)
          expect(page).to have_content(order1_time)
          expect(page).to have_content(@order1.total)
          expect(page).to have_content('Status: Ordered')
          expect(page).to have_link 'Cancel'
        end

        within("tr#order-#{@order2.id}") do
          expect(page).to have_content(@order2.id)
          expect(page).to have_content(order2_time)
          expect(page).to have_content(@order2.total)
          expect(page).to have_content('Status: Cancelled')
          expect(page).to_not have_link 'Cancel'
        end
      end
    end

    scenario 'can click a list item to link to the past order' do
      within("tr#order-#{@order1.id}") do
        click_on(@order1.id)
      end
      expect(current_path).to eq(order_path(@order1))
    end
  end
end
