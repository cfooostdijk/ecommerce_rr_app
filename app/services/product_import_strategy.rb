class ProductImportStrategy
  STRATEGIES = {
    api: ApiImporter::FetchProducts,
    csv: CsvImporter::FetchProducts
  }.freeze

  def initialize(strategy, file = nil)
    @strategy = STRATEGIES[strategy.to_sym]
    @file = file
  end

  def execute
    if @strategy
      result = @strategy.call(file: @file)
      { success: result.success?, message: result.message }
    else
      { success: false, message: 'Invalid strategy' }
    end
  end
end
