# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:api_id) { |n| n }
    title { 'Sample Product' }
    description { 'This is a sample product description.' }
    price { 9.99 }
    image_url { 'http://example.com/image.png' }
  end
end
