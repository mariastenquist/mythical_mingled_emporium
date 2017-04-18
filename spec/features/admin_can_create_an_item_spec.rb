require 'rails_helper'

RSpec.feature 'Admin can create an item' do
  context 'all input provided' do 
    scenario 'admin creates an item' do
      create :user, role: 1
      create :category, name: 'wtf'

      visit new_admin_creature_path

      fill_in 'creature[breed]', with: 'PigHuman'
      fill_in 'creature[price]', with: '100.00'
      fill_in 'creature[description]', with: 'Oh god what have we done?'
      fill_in 'creature[image_url]', with: 'http://bit.ly/2pQ0Oc9'
      select 'wtf', from: 'creature[categories]'

      # click_on 'Add photo'
      # attach_file 'File', 'spec/asset_specs/photo.jpg'
      # click_on 'Add photo'

      click_on 'Create'

      expect(current_path).to eq admin_creature_path(Creature.first.id)

      expect(page).to have_content 'PigHuman'
      expect(page).to have_content 'Price: $100.00'
      expect(page).to have_content 'Description: Oh god what have we done?'
      expect(page).to have_content 'Description: Oh god what have we done?'
      expect(page).to have_selector 'img'
    end
  end

  context 'admin provides incomplete information' do

  end

  context 'admin is able to add a photo or have default' do

  end
end
