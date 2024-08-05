# frozen_string_literal: true

# Class to define order_item
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product, :quantity, :price, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  def total_price
    quantity * price
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id order_id price product_id quantity updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order product]
  end
end
