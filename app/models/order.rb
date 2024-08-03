class Order < ApplicationRecord
  belongs_to :product

  validates :customer_first_name, :customer_last_name, :customer_email, :total, presence: true
  validates :customer_email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.ransackable_attributes(auth_object = nil)
    ["customer_first_name", "customer_last_name", "customer_email", "total", "created_at", "updated_at", "product_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["product"]
  end
end
