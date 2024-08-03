class FetchFromApi
  include Interactor

  def call
    response = Faraday.get('https://fakestoreapi.com/products')

    if response.success?
      context.response = response
    else
      context.fail!(message: 'Failed to fetch products')
    end
  end
end
