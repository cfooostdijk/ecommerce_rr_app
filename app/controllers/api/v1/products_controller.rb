# frozen_string_literal: true

module Api
  module V1
    # Class to define products
    class ProductsController < ApplicationController
      def index
        @products = Product.all
        render json: @products
      end

      def show
        product = Product.find_by(id: params[:id])

        if product
          render json: product
        else
          render json: { error: 'Product not found' }, status: :not_found
        end
      end
    end
  end
end
