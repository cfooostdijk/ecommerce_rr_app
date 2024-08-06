# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Orders', type: :request do
  describe 'POST /api/v1/orders' do
    let(:product) { create(:product) }
    let(:valid_attributes) do
      {
        order: {
          customer_first_name: 'John',
          customer_last_name: 'Doe',
          customer_email: 'john.doe@example.com',
          total: 100.0,
          order_items_attributes: [
            {
              product_id: product.id,
              quantity: 2,
              price: 50.0
            }
          ]
        }
      }
    end

    let(:invalid_attributes) do
      {
        order: {
          customer_first_name: '',
          customer_last_name: '',
          customer_email: 'invalid_email',
          total: 0,
          order_items_attributes: []
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new order' do
        expect do
          post '/api/v1/orders', params: valid_attributes
        end.to change(Order, :count).by(1)
      end

      it 'returns a created status' do
        post '/api/v1/orders', params: valid_attributes
        expect(response).to have_http_status(:created)
      end

      it 'returns the created order' do
        post '/api/v1/orders', params: valid_attributes
        expect(JSON.parse(response.body)['customer_first_name']).to eq('John')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new order' do
        expect do
          post '/api/v1/orders', params: invalid_attributes
        end.not_to change(Order, :count)
      end

      it 'returns an unprocessable entity status' do
        post '/api/v1/orders', params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the errors' do
        post '/api/v1/orders', params: invalid_attributes
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end
end
