class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :customer_first_name, :customer_last_name, :customer_email, presence: true
  validates :customer_email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.ransackable_attributes(auth_object = nil)
    ["customer_first_name", "customer_last_name", "customer_email", "total", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "products"]
  end

  def calculate_total
    self.total = order_items.sum('price * quantity')
  end
end
