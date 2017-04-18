require 'rails_helper'

RSpec.feature 'Admin can view dashboard' do
  context 'user is logged in as an admin' do
    scenario 'Admin logs in and goes to view dashboard' do
      admin = create(:user, role: 'admin')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      within('h1') do
        expect(page).to have_content('Admin Dashboard')
      end
      expect(page).to have_content("Username: #{admin.username}")
      expect(page).to have_content("Email: #{admin.email}")
      expect(page).to have_content("Role: #{admin.role}")
    end
  end
end
