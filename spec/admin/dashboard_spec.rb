# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard in ActiveAdmin', type: :feature do
  before do
    @admin_user = create(:admin_user)
    login_as(@admin_user, scope: :admin_user)
  end

  it 'displays the welcome message on the dashboard' do
    visit admin_root_path

    expect(page).to have_content(I18n.t('active_admin.dashboard_welcome.welcome'))
    expect(page).to have_content(I18n.t('active_admin.dashboard_welcome.call_to_action'))
  end
end
