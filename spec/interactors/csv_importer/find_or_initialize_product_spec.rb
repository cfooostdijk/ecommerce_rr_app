# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CsvImporter::FindOrInitializeProduct, type: :interactor do
  describe '.call' do
    let(:row1) do
      { 'id' => 1, 'api_id' => 123, 'title' => 'Product1', 'description' => 'Description1', 'price' => 10.0,
        'image_url' => 'http://example.com/image1.jpg' }
    end
    let(:row2) do
      { 'id' => 2, 'api_id' => 124, 'title' => 'Product2', 'description' => 'Description2', 'price' => 20.0,
        'image_url' => 'http://example.com/image2.jpg' }
    end
    let(:rows) { [row1, row2] }
    let(:context) { Interactor::Context.new(rows:) }

    before do
      allow(Product).to receive(:find_or_initialize_by).with(id: row1['id']).and_return(Product.new(id: row1['id']))
      allow(Product).to receive(:find_or_initialize_by).with(id: row2['id']).and_return(Product.new(id: row2['id']))
    end

    context 'when finding or initializing products is successful' do
      it 'sets the products in the context' do
        result = described_class.call(context)

        expect(result.success?).to be true
        expect(result.products).not_to be_nil
        expect(result.products.size).to eq(2)
        expect(result.products.first.id).to eq(row1['id'])
        expect(result.products.last.id).to eq(row2['id'])
        expect(result.products.first.api_id).to eq(row1['api_id'])
        expect(result.products.last.api_id).to eq(row2['api_id'])
        expect(result.products.first.title).to eq(row1['title'])
        expect(result.products.last.title).to eq(row2['title'])
        expect(result.products.first.description).to eq(row1['description'])
        expect(result.products.last.description).to eq(row2['description'])
        expect(result.products.first.price).to eq(row1['price'])
        expect(result.products.last.price).to eq(row2['price'])
        expect(result.products.first.image_url).to eq(row1['image_url'])
        expect(result.products.last.image_url).to eq(row2['image_url'])
      end
    end

    context 'when finding or initializing products fails' do
      before do
        allow(Product).to receive(:find_or_initialize_by).and_raise(StandardError, 'Initialization error')
      end

      it 'fails the context with an error message' do
        result = described_class.call(context)

        expect(result).to be_failure
        expect(result.message).to eq('Failed to find or initialize products: Initialization error')
      end
    end
  end
end
