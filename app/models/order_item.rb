class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product, :quantity, :price, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  def total_price
    quantity * price
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "price", "product_id", "quantity", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order", "product"]
  end
end
