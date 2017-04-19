require 'rails_helper'

RSpec.feature 'Admin can create an item' do
  attr_reader :admin

  before do
    @admin = create :user, role: 1
    create :category, name: 'wtf'
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_creature_path
  end
  context 'all input provided' do
    scenario 'admin creates an item' do
      fill_in 'creature[breed]', with: 'PigHuman'
      fill_in 'creature[price]', with: '100.00'
      fill_in 'creature[description]', with: 'Oh god what have we done?'
      fill_in 'creature[image_url]', with: 'http://bit.ly/2pQ0Oc9'
      select 'wtf', from: 'creature[categories]'

      click_on 'Create'

      expect(current_path).to eq admin_creature_path(Creature.first.id)

      expect(page).to have_content 'PigHuman'
      expect(page).to have_content 'Price: $100.00'
      expect(page).to have_content 'Description: Oh god what have we done?'
      expect(page).to have_selector 'img'
      expect(page).to have_content 'Creature successfully created!'
    end
  end

  context 'admin provides incomplete information' do
    scenario 'and admin cannot create item, gets error flash' do
      fill_in 'creature[breed]', with: ''
      fill_in 'creature[price]', with: '100.00'
      fill_in 'creature[description]', with: 'Oh god what have we done?'
      fill_in 'creature[image_url]', with: 'http://bit.ly/2pQ0Oc9'
      select 'wtf', from: 'creature[categories]'

      click_on 'Create'

      expect(current_path).to eq(admin_creatures_path)
      expect(page).to have_content('Retry creature creation')
    end
  end

  context 'admin is able to add a photo or have default' do
    scenario 'admin lets default go through' do
      fill_in 'creature[breed]', with: 'PigHuman'
      fill_in 'creature[price]', with: '100.00'
      fill_in 'creature[description]', with: 'Oh god what have we done?'
      select 'wtf', from: 'creature[categories]'

      click_on 'Create'

      expect(current_path).to eq admin_creature_path(Creature.first.id)
      expect(page).to have_selector 'img'
      expect(page).to have_content 'Creature successfully created!'
    end
  end
end
