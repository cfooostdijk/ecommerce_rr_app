class Product < ApplicationRecord
  validates :api_id, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["api_id", "title", "description", "price", "image_url", "created_at", "updated_at"]
  end
end
