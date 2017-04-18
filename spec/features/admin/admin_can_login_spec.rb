require 'rails_helper'

RSpec.feature 'Admin can login' do
  it 'and see dashboard' do
    admin = create :user, role: 1

    visit login_path

    fill_in 'session[username]', with: admin.username
    fill_in 'session[password]', with: admin.password

    click_on 'Login'

    expect(current_path).to eq admin_dashboard_path
  end
end
