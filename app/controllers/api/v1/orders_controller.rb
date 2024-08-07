# frozen_string_literal: true

module Api
  module V1
    # Class to define orders
    class OrdersController < ApplicationController
      protect_from_forgery with: :null_session

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
        params.require(:order).permit(:customer_first_name, :customer_last_name, :customer_email, :total,
                                      order_items_attributes: %i[product_id quantity price])
      end
    end
  end
end
