# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminUsers in ActiveAdmin', type: :feature do
  before do
    @admin_user = create(:admin_user)
    login_as(@admin_user, scope: :admin_user)
  end

  it 'displays the list of AdminUsers' do
    visit admin_admin_users_path
    expect(page).to have_content('Admin Users')
    expect(page).to have_content(@admin_user.email)
  end

  it 'shows the form for creating a new AdminUser' do
    visit new_admin_admin_user_path

    fill_in 'Email', with: 'new_admin@example.com'
    fill_in 'admin_user_password', with: 'password'
    fill_in 'admin_user_password_confirmation', with: 'password'

    click_button 'Create Admin user'

    expect(page).to have_content('Admin user was successfully created.')
    expect(page).to have_content('new_admin@example.com')
  end
end
