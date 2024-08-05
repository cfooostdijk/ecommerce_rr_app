# frozen_string_literal: true

module ApiImporter
  # Class to define interactor
  class SaveProducts
    include Interactor

    def call
      context.products.each do |product_data|
        process_product(product_data)
      end
    rescue StandardError => e
      context.fail!(message: "Failed to save products: #{e.message}")
    end

    private

    def process_product(product_data)
      product = find_or_initialize_product(product_data['id'])
      update_product(product, product_data)
    end

    def find_or_initialize_product(api_id)
      Product.find_or_initialize_by(api_id:)
    end

    def update_product(product, product_data)
      product.update!(
        title: product_data['title'],
        description: product_data['description'],
        price: product_data['price'],
        image_url: product_data['image']
      )
    end
  end
end
