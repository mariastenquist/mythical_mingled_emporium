require 'rails_helper'

RSpec.feature 'User is able to add items to cart' do
  context 'User is not logged in' do
    scenario 'a user adds an item to their cart' do
      creature1, creature2 = create_list(:creature, 2)
      total_price = "$#{creature1.price.to_f + creature2.price.to_f}0"
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

      expect(page).to have_css("img[src*='#{creature1.id}?set']")
      expect(page).to have_content("Breed: #{creature1.breed}")
      expect(page).to have_content("Unit Price: $#{creature1.price}0")
      expect(page).to have_content('Quantity: 1')
      expect(page).to have_content("Total Price: #{total_price}")
    end
  end
end
