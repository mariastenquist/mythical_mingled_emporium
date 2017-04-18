require 'rails_helper'

RSpec.feature 'Admin can create an item' do
  scenario 'admin creates an item' do
    create :user, role: 1
    create :category, name: 'wtf'

    visit new_admin_creature_path

    fill_in 'creature[breed]', with: 'PigHuman'
    fill_in 'creature[price]', with: '100.00'
    fill_in 'creature[description]', with: 'Oh god what have we done?'
    select 'wtf', from: 'creature[categories]'

    # from: http://www.charliemassry.com/posts/29-testing-paperclip-with-rspec-capybara-and-factory-girl
    click_on 'Add photo'
    attach_file 'File', 'spec/asset_specs/photo.jpg'
    click_on 'Add photo'

    click_on 'Create'

    expect(current_path).to eq creature_path(Creature.first.id)

    expect(page).to have_content 'PigHuman'
    expect(page).to have_content 'Price: $100.00'
    expect(page).to have_content 'Description: Oh god what have we done?'
    expect(page).to have_content 'Description: Oh god what have we done?'
    expect(page).to have_selector 'img'
  end
end
