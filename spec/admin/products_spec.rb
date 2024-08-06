# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Products', type: :feature do
  before do
    @admin_user = create(:admin_user)
    login_as(@admin_user, scope: :admin_user)
    @product = create(:product, title: 'Sample Product', description: 'Product Description', price: 10.0, api_id: 41,
                                image_url: 'http://example.com/sample-product.jpg')
  end

  describe 'Index page' do
    it 'shows a list of products with correct columns' do
      visit admin_products_path

      expect(page).to have_content('Sample Product')
      expect(page).to have_content('Product Description')
      expect(page).to have_content('10.0')
      expect(page).to have_content('41')
      expect(page).to have_selector("img[src*='sample-product.jpg']")
    end
  end

  describe 'Show page' do
    it 'displays product details' do
      visit admin_product_path(@product)

      expect(page).to have_content('Sample Product')
      expect(page).to have_content('Product Description')
      expect(page).to have_content('10.0')
      expect(page).to have_content('41')
      expect(page).to have_selector("img[src*='sample-product.jpg']")
    end
  end

  describe 'Create product' do
    it 'creates a new product' do
      visit new_admin_product_path

      fill_in 'Title', with: 'New Product'
      fill_in 'Description', with: 'New Product Description'
      fill_in 'Price', with: '30.0'
      fill_in 'Image url', with: 'http://example.com/image.jpg'
      fill_in 'Api', with: '12345'

      click_button 'Create Product'

      expect(page).to have_content('Product was successfully created.')
    end
  end

  describe 'Import actions' do
    let(:csv_file) { Rails.root.join('spec', 'fixtures', 'files', 'products.csv') }

    it 'imports products from CSV file' do
      visit csv_import_admin_products_path

      expect(page).to have_selector("form[action='#{import_csv_admin_products_path}']")

      attach_file('Upload CSV', Rails.root.join('spec/fixtures/files/products.csv'))

      click_button 'Upload CSV'

      expect(page).to have_content('Products imported successfully!')
    end

    it 'handles missing CSV file' do
      visit csv_import_admin_products_path

      expect(page).to have_button('Upload CSV')

      click_button 'Upload CSV'

      expect(page).to have_content('No file providedor or No source specified.')
    end
  end
end
