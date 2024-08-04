module CsvImporter
  class UpdateProduct
    include Interactor

    def call
      context.products.each do |product|
        product.save!
      end
    rescue StandardError => e
      context.fail!(message: "Failed to save products: #{e.message}")
    end
  end
end
