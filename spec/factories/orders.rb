# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    customer_first_name { 'John' }
    customer_last_name { 'Doe' }
    customer_email { 'john.doe@example.com' }
    total { 0.0 }

    transient do
      items_count { 0 }
    end

    after(:create) do |order, evaluator|
      create_list(:order_item, evaluator.items_count, order:) if evaluator.items_count.positive?
    end
  end
end
