class ProductsController < ApplicationController
  def index
    result = FetchProducts.call

    if result.success?
      @products = result.products
      render json: @products
    else
      render json: { error: result.message }, status: :unprocessable_entity
    end
  end
end
