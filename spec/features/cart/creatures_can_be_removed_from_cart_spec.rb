require 'rails_helper'

RSpec.feature 'User is able to remove items from cart' do
  context 'User is not logged in' do
    scenario 'a user removes an item from their cart' do
      creature1, creature2 = create_list(:creature, 2)
      success = "Successfully removed #{creature1.breed} from your cart."

      visit '/creatures'

      within "#creature-#{creature1.id}" do
        click_on 'Add to Cart'
      end
      within "#creature-#{creature2.id}" do
        click_on 'Add to Cart'
      end

      within 'div.nav-wrapper' do
        click_on 'View Cart'
      end

      expect(current_path).to eq(cart_path)

      within("#cart-creature-#{creature1.id}") do
        click_on 'Remove Item'
      end

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(success)
      expect(page).to have_link(creature1.breed)
      expect(page).to_not have_content("Breed: #{creature1.breed}")
      expect(page).to have_content("Breed: #{creature2.breed}")
    end
  end
end
