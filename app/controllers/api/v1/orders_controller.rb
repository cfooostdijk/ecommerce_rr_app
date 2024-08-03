module Api
  module V1
    class OrdersController < ApplicationController
      def create
        order = Order.new(order_params)
        if order.save
          render json: order, status: :created
        else
          render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def order_params
        params.require(:order).permit(:customer_first_name, :customer_last_name, :customer_email, order_items_attributes: [:product_id, :quantity, :price])
      end
    end
  end
end
