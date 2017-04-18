require 'rails_helper'

RSpec.feature 'Admin can see all creatures' do
  context 'Admin is logged in' do
    scenario 'Admin views all creatures' do
      admin = create :user, role: 1
      creature1, creature2 = create_list :creature, 2
      creature1.retired!

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      expect(page).to have_link('View All Creatures')

      click_on 'View All Creatures'

      expect(current_path).to eq admin_creatures_path

      within('.creatures') do
        within("#creature-#{creature1.id}") do
          expect(page).to have_css("img[src*='#{creature1.id}?set']")
          expect(page).to have_link(creature1.breed)
          expect(page).to have_content(creature1.description)
          expect(page).to have_content(creature1.status)
          expect(page).to have_link('Edit')
        end

        within("#creature-#{creature2.id}") do
          expect(page).to have_css("img[src*='#{creature2.id}?set']")
          expect(page).to have_link(creature2.breed)
          expect(page).to have_content(creature2.description)
          expect(page).to have_content(creature2.status)
          expect(page).to have_link('Edit')
        end
      end
    end
  end
end
