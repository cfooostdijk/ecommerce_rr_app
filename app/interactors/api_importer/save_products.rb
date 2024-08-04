module ApiImporter
  class SaveProducts
    include Interactor

    def call
      context.products.each do |product_data|
        product = Product.find_or_initialize_by(api_id: product_data['id'])

        product.update!(
          title: product_data['title'],
          description: product_data['description'],
          price: product_data['price'],
          image_url: product_data['image']
        )
      end
    rescue => e
      context.fail!(message: "Failed to save products, #{e}")
    end
  end
end
