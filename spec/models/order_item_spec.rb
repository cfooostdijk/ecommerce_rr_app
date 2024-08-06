# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should belong_to(:order) }
  it { should belong_to(:product) }

  it { should validate_presence_of(:product) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  describe '#total_price' do
    it 'calculates the total price of the order item' do
      order_item = FactoryBot.build(:order_item, quantity: 2, price: 10.0)
      expect(order_item.total_price).to eq(20.0)
    end
  end

  describe '.ransackable_attributes' do
    it 'returns an array of ransackable attributes' do
      expect(OrderItem.ransackable_attributes).to match_array(%w[created_at id order_id price product_id quantity
                                                                 updated_at])
    end
  end

  describe '.ransackable_associations' do
    it 'returns an array of ransackable associations' do
      expect(OrderItem.ransackable_associations).to match_array(%w[order product])
    end
  end
end
