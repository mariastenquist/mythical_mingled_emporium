require 'rails_helper'

RSpec.feature 'Guest user cart functionality' do
  scenario 'a guest user needs to login before checkout when items in cart' do
    creature1, creature2 = create_list(:creature, 2)

    visit '/creatures'

    within "#creature-#{creature1.id}" do
      click_on 'Add to Cart'
    end
    within "#creature-#{creature2.id}" do
      click_on 'Add to Cart'
    end

    visit '/cart'

    expect(page).to have_content("Breed: #{creature1.breed}")
    expect(page).to have_content("Breed: #{creature2.breed}")
    expect(page).to_not have_button 'Checkout'
    expect(page).to have_content('Login or Create Account to Checkout')

    click_on 'Create Account'

    fill_in 'user[username]', with: 'Billybob'
    fill_in 'user[email]', with: 'billybob@bbc.com'
    fill_in 'user[password]', with: 'hunter2'
    fill_in 'user[password_confirmation]', with: 'hunter2'

    click_on 'Sign Up!'

    click_on 'View Cart'

    expect(page).to have_content("Breed: #{creature1.breed}")
    expect(page).to have_content("Breed: #{creature2.breed}")

    click_on 'Logout'

    expect(page).to have_button('Login')
    expect(page).to_not have_button('Logout')
  end
end
