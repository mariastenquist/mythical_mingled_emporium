require 'rails_helper'

RSpec.feature 'User can view a creature show page' do
  context 'Where a creature is retired' do
    scenario 'From a past order page' do
      creature = create(:creature)
      creature.retired!
      user = create(:user)
      user.orders << create(:order)
      order = user.orders.first
      OrderCreature.create(order: order, creature: creature, quantity: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit order_path(order)

      click_on creature.breed

      expect(current_path).to eq creature_path(creature)

      expect(page).to_not have_button 'Add to Cart'
      expect(page).to have_content 'Creature Retired'
    end
  end

  context 'Where a creature is active' do
    scenario 'From the creatures page' do
      creature = create(:creature)

      visit creatures_path

      click_on creature.breed

      expect(current_path).to eq creature_path(creature)

      expect(page).to have_css("img[src*='#{creature.id}?set']")
      expect(page).to have_content creature.breed
      expect(page).to have_content "Price: $#{creature.price}0"
      expect(page).to have_content "Description: #{creature.description}"

      expect(page).to have_button 'Add to Cart'
    end
  end
end
