module Api
  module V1
    class OrdersController < ApplicationController
      def create
        product = Product.find(params[:product_id])
        total_amount = product.price
        order = Order.new(order_params.merge(total: total_amount))
        order.product = product

        if order.save
          render json: order, status: :created
        else
          render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def order_params
        params.require(:order).permit(:customer_first_name, :customer_last_name, :customer_email)
      end
    end
  end
end
