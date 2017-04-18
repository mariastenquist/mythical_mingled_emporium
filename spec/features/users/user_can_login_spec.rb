require 'rails_helper'

RSpec.feature 'User can login' do
  it 'has an account' do
    user1 = create(:user)

    visit login_path

    fill_in 'session[username]', with: user1.username
    fill_in 'session[password]', with: user1.password

    within 'main' do
      click_on 'Login'
    end

    expect(current_path).to eq dashboard_path
    within('div.flash') do
      expect(page).to have_content('Login successful')
    end
    expect(page).to have_content("Username: #{user1.username}")
    expect(page).to have_content("Email: #{user1.email}")
  end
  it 'does not have an account' do
    visit login_path
    fill_in 'session[username]', with: 'ajlkfajsafjkl'
    fill_in 'session[password]', with: 'dsjafljlksfaj'

    within 'main' do
      click_on 'Login'
    end

    expect(current_path).to eq login_path

    within('div.flash') do
      expect(page).to have_content('Login failed')
      expect(page).to_not have_content('Login successful')
    end
  end
end
