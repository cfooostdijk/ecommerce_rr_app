# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders in ActiveAdmin', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let!(:product) { create(:product, title: 'Sample Product') }
  let!(:order) do
    create(:order, customer_first_name: 'John', customer_last_name: 'Doe', customer_email: 'john.doe@example.com',
                   total: 100, order_items_attributes: [{ product:, quantity: 2, price: 50 }])
  end

  before do
    login_as(admin_user, scope: :admin_user)
  end

  describe 'index page' do
    it 'displays the list of orders' do
      visit admin_orders_path

      expect(page).to have_content('Orders')
      expect(page).to have_content(order.customer_first_name)
      expect(page).to have_content(order.customer_last_name)
      expect(page).to have_content(order.customer_email)
      expect(page).to have_content(order.total)
      expect(page).to have_selector('img')
      expect(page).to have_content(product.title)
    end
  end

  describe 'show page' do
    it 'displays order details' do
      visit admin_order_path(order)

      expect(page).to have_content(order.customer_first_name)
      expect(page).to have_content(order.customer_last_name)
      expect(page).to have_content(order.customer_email)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.created_at.strftime('%B %d, %Y %H:%M'))
      expect(page).to have_content(order.updated_at.strftime('%B %d, %Y %H:%M'))
      expect(page).to have_selector('img')
      expect(page).to have_content(product.title)
    end
  end

  describe 'form page' do
    it 'creates a new order', js: true do
      visit new_admin_order_path

      fill_in 'Customer first name', with: 'Jane'
      fill_in 'Customer last name', with: 'Smith'
      fill_in 'Customer email', with: 'jane.smith@example.com'
      fill_in 'Total', with: '200'

      click_on 'Add New Order item'

      expect(page).to have_selector('select[name*="order[order_items_attributes][0][product_id]"]', wait: 5)

      select 'Sample Product', from: 'order_order_items_attributes_0_product_id'

      fill_in 'order_order_items_attributes_0_quantity', with: '1'
      fill_in 'order_order_items_attributes_0_price', with: '200'

      click_button 'Create Order'

      expect(page).to have_content('Order was successfully created.')
      expect(page).to have_content('Jane')
      expect(page).to have_content('Smith')
      expect(page).to have_content('jane.smith@example.com')
      expect(page).to have_content('200')
      expect(page).to have_content('Sample Product')
    end
  end
end
