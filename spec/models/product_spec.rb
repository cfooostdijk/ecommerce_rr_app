# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_many(:order_items).dependent(:destroy) }
  it { should have_many(:orders).through(:order_items) }

  it { should validate_uniqueness_of(:api_id) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      product = FactoryBot.build(:product)
      expect(product).to be_valid
    end

    it 'is not valid without an api_id' do
      product = FactoryBot.build(:product, api_id: nil)
      expect(product).not_to be_valid
    end
  end

  describe '.ransackable_attributes' do
    it 'returns an array of ransackable attributes' do
      expect(Product.ransackable_attributes).to match_array(%w[api_id title description price image_url created_at
                                                               updated_at])
    end
  end
end
