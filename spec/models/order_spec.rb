# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_many(:order_items).dependent(:destroy) }
  it { should have_many(:products).through(:order_items) }

  it { should accept_nested_attributes_for(:order_items).allow_destroy(true) }

  it { should validate_presence_of(:customer_first_name) }
  it { should validate_presence_of(:customer_last_name) }
  it { should validate_presence_of(:customer_email) }
  it { should allow_value('email@example.com').for(:customer_email) }
  it { should_not allow_value('email').for(:customer_email) }

  describe '#calculate_total' do
    it 'calculates the total price of all order items' do
      order = create(:order)
      create(:order_item, order:, price: BigDecimal('10.0'), quantity: 2)
      create(:order_item, order:, price: BigDecimal('20.0'), quantity: 1)
      order.calculate_total
      expect(order.total).to eq(BigDecimal('40.0'))
    end
  end

  describe '.ransackable_attributes' do
    it 'returns an array of ransackable attributes' do
      expect(Order.ransackable_attributes).to match_array(%w[customer_first_name customer_last_name customer_email
                                                             total created_at updated_at])
    end
  end

  describe '.ransackable_associations' do
    it 'returns an array of ransackable associations' do
      expect(Order.ransackable_associations).to match_array(%w[order_items products])
    end
  end
end
