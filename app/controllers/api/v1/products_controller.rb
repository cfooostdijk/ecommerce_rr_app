module Api
  module V1
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

      def show
        product = Product.find_by(id: params[:id])

        if product
          render json: product
        else
          render json: { error: "Product not found" }, status: :not_found
        end
      end
    end
  end
end