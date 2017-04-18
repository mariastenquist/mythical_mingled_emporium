require 'rails_helper'

RSpec.feature 'Admin edits and creature' do
  context 'as a logged in admin' do
    scenario 'admin can edit the creature details' do
      admin = create(:user, role: 1)
      creature = create(:creature)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_creatures_path

      click_on('Edit')

      expect(current_path).to eq(edit_admin_creature_path(creature))

      within('.creature') do
        expect(page).to have_field('creature[breed]')
        expect(page).to have_field('creature[description]')
        expect(page).to have_field('creature[image_url]')
        expect(page).to have_field('creature[status]')

        expect(find_field('creature[breed]').value).to eq(creature.breed)
        expect(find_field('creature[description]').value).to eq(creature.description)
        expect(find_field('creature[image_url]').value).to eq(creature.image_url)
        expect(find_field('creature_status_active').checked?).to be(true)
        expect(find_field('creature_status_retired').checked?).to be(false)
      end

      fill_in 'creature[breed]', with: 'Whatisthis'
      fill_in 'creature[description]', with: 'Very angry animal'
      fill_in 'creature[image_url]', with: 'http://bit.ly/2oiL0yl'
      choose 'creature_status_retired'

      click_on 'Update Creature'

      within("#creature-#{creature.id}") do
        expect(page).to have_content('Breed: Whatisthis')
        expect(page).to have_content('Description: Very angry animal')
        expect(page).to have_css("img[src='http://bit.ly/2oiL0yl']")
        expect(page).to have_content('Status: Retired')
      end
    end
  end
end
