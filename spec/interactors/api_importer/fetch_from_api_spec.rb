# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiImporter::FetchFromApi, type: :interactor do
  describe '.call' do
    context 'when the API request is successful' do
      it 'sets the response in the context', vcr: { cassette_name: 'fetch_from_api_success' } do
        interactor = ApiImporter::FetchFromApi.call

        expect(interactor).to be_a_success
        expect(interactor.response).to be_a(Faraday::Response)

        response_body = JSON.parse(interactor.response.body)
        expect(response_body).to be_an(Array)
        expect(response_body.first).to have_key('title')
      end
    end

    context 'when the API request fails' do
      before do
        stub_request(:get, 'https://fakestoreapi.com/products')
          .to_return(status: 500, body: 'Internal Server Error', headers: { 'Content-Type' => 'text/plain' })
      end

      it 'fails with an error message' do
        interactor = ApiImporter::FetchFromApi.call

        expect(interactor).to be_a_failure
        expect(interactor.message).to eq('Failed to fetch products')
      end
    end
  end
end
