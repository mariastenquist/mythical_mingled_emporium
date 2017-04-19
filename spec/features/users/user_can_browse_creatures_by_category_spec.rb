require 'rails_helper'

RSpec.feature 'User is able to see creatures by category' do
  scenario 'a user visits a category vanity url' do
    category = create(:category, name: 'cute')
    category_two = create(:category, name: 'scary')

    creature = create(:creature)
    creature_two = create(:creature)
    creature_three = create(:creature)
    creature_four = create(:creature)

    category.creatures << [creature, creature_two]
    category_two.creatures << [creature_three, creature_four]

    visit '/cute'

    expect(current_path).to eq category_path(category.name)
    expect(page).to have_link(creature.breed)
    expect(page).to have_link(creature_two.breed)
    expect(page).to_not have_link(creature_three.breed)
    expect(page).to_not have_link(creature_four.breed)

    within('ul.category-creatures') do
      expect(page).to have_link creature.breed
      expect(page).to have_link creature_two.breed
      expect(page).to have_selector('li', count: 2)
      expect(page).to have_css("img[src*='#{creature.id}?set']")
      expect(page).to have_css("img[src*='#{creature_two.id}?set']")
      expect(page).to have_content("Price: #{creature.price}")
      expect(page).to have_content("Price: #{creature_two.price}")
    end
  end
end
