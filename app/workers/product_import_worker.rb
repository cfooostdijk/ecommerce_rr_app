class ProductImportWorker
  include Sidekiq::Worker

  def perform(strategy, file = nil)
    result = ProductImportStrategy.new(strategy, file).execute

    if result[:success]
      Rails.logger.info("Products imported successfully!")
    else
      Rails.logger.error("Failed to import products: #{result[:message]}")
    end
  end
end
