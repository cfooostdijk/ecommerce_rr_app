# frozen_string_literal: true

# Class to define product
class Product < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  validates :api_id, presence: true, uniqueness: true, numericality: { only_integer: true }

  def self.ransackable_attributes(_auth_object = nil)
    %w[api_id title description price image_url created_at updated_at]
  end
end
