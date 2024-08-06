# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  describe 'GET /api/v1/products' do
    before do
      create_list(:product, 3)
    end

    it 'returns a list of products' do
      get '/api/v1/products'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /api/v1/products/:id' do
    let(:product) { create(:product) }

    context 'when the product exists' do
      it 'returns the product' do
        get "/api/v1/products/#{product.id}"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(product.id)
      end
    end

    context 'when the product does not exist' do
      it 'returns a not found message' do
        get '/api/v1/products/99999'
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Product not found')
      end
    end
  end
end
