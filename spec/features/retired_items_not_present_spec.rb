require 'rails_helper'

RSpec.feature 'Retired items do not appear for general shopping' do
  context 'so a logged in user' do
    scenario 'should not see a retired item on the various views' do
      user = create(:user)
      creature1, creature2 = create_list(:creature, 2)
      creature1.retired!
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit creatures_path

      within('.creatures') do
        expect(page).to have_link(creature2.breed)
        expect(page).to_not have_link(creature1.breed)
      end

      visit categories_path

      expect(page).to have_content(creature2.breed)
      expect(page).to_not have_content(creature1.breed)
    end
  end

  context 'so an not logged in user' do
    scenario 'should not see a retired item in the views' do
      creature1, creature2 = create_list(:creature, 2)
      creature1.retired!

      visit creatures_path

      within('.creatures') do
        expect(page).to have_link(creature2.breed)
        expect(page).to_not have_link(creature1.breed)
      end

      visit categories_path

      expect(page).to have_content(creature2.breed)
      expect(page).to_not have_content(creature1.breed)
    end
  end

  context 'so an admin' do
    scenario 'should not see a retired item in the views' do
      admin = create(:user, role: 1)
      creature1, creature2 = create_list(:creature, 2)
      creature1.retired!
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit creatures_path

      within('.creatures') do
        expect(page).to have_link(creature2.breed)
        expect(page).to_not have_link(creature1.breed)
      end

      visit categories_path

      expect(page).to have_content(creature2.breed)
      expect(page).to_not have_content(creature1.breed)

      visit admin_creatures_path

      expect(page).to have_link(creature2.breed)
      expect(page).to_not have_link(creature1.breed)
    end
  end

  context 'but a logged in user with past orders containing retired items' do
    scenario 'should see the retired item in her past order' do
      user = create(:user)
      creature1, creature2 = create_list(:creature, 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit creatures_path

      within "#creature-#{creature1.id}" do
        click_on 'Add to Cart'
      end
      within "#creature-#{creature2.id}" do
        click_on 'Add to Cart'
      end
      within 'div.nav-wrapper' do
        click_on 'View Cart'
      end

      click_on 'Checkout'

      creature1.retired!

      visit dashboard_path

      click_on('Order #: 1')

      expect(page).to have_link(creature1.id)
      expect(page).to have_link(creature2.id)

      within('#creature-1') do
        click_on(creature1.id)
      end

      expect(current_path).to eq(creature_path(creature1))
      expect(creature1.status).to eq('retired')
      expect(page).to have_content('Retired')
      expect(page).to_not have_button('Add to Cart')
    end
  end
end
