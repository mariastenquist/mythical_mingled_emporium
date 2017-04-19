require 'rails_helper'

RSpec.feature 'Cart empties after an order is placed' do
  context 'A user is logged in' do
    scenario 'A user buys a creature' do
      user = create :user
      creature = create :creature

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit creatures_path

      click_on 'Add to Cart'

      expect(current_path).to eq creatures_path

      click_on 'View Cart'

      expect(current_path).to eq cart_path

      expect(page).to have_link creature.breed

      click_on 'Checkout'

      expect(current_path).to eq orders_path

      click_on 'View Cart'

      expect(page).to_not have_link creature.breed

      within '.cart-creatures' do
        # I'm in favor of these being something besides 'li's
        # We could prob make some cool 'creature-order' cards
        expect(page).to have_selector('li', count: 0)
      end
    end
  end
end
