# frozen_string_literal: true

module CsvImporter
  # Class to define interactor
  class UpdateProduct
    include Interactor

    def call
      context.products.each(&:save!)
    rescue StandardError => e
      context.fail!(message: "Failed to save products: #{e.message}")
    end
  end
end
