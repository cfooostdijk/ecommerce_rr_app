# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CsvImporter::UpdateProduct, type: :interactor do
  describe '.call' do
    let(:product1) { instance_double(Product, save!: true) }
    let(:product2) { instance_double(Product, save!: true) }
    let(:products) { [product1, product2] }
    let(:context) { Interactor::Context.new(products:) }

    context 'when saving products is successful' do
      it 'does not fail the context' do
        result = described_class.call(context)

        expect(result.success?).to be true
        expect(result.message).to be_nil
      end
    end

    context 'when saving products fails' do
      before do
        allow(product1).to receive(:save!).and_raise(StandardError, 'Save error')
      end

      it 'fails the context with an error message' do
        result = described_class.call(context)

        expect(result).to be_failure
        expect(result.message).to eq('Failed to save products: Save error')
      end
    end
  end
end
