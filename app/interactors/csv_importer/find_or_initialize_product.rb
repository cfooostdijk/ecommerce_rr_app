# frozen_string_literal: true

module CsvImporter
  # Class to define interactor
  class FindOrInitializeProduct
    include Interactor

    def call
      context.products = context.rows.map do |row|
        product = Product.find_or_initialize_by(id: row['id'])
        product.assign_attributes(row)
        product
      end
    rescue StandardError => e
      context.fail!(message: "Failed to find or initialize products: #{e.message}")
    end
  end
end
