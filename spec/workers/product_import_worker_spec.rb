# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ProductImportWorker, type: :worker do
  before do
    Sidekiq::Testing.fake!
  end

  let(:strategy) { 'some_strategy' }
  let(:file) { 'path/to/file.csv' }
  let(:product_import_strategy) { instance_double(ProductImportStrategy) }

  describe '#perform' do
    context 'when the import is successful' do
      before do
        allow(ProductImportStrategy).to receive(:new).with(strategy, file).and_return(product_import_strategy)
        allow(product_import_strategy).to receive(:execute).and_return(success: true)
        allow(Rails.logger).to receive(:info)
      end

      it 'logs a success message' do
        expect(Rails.logger).to receive(:info).with('Products imported successfully!')
        subject.perform(strategy, file)
      end
    end

    context 'when the import fails' do
      before do
        allow(ProductImportStrategy).to receive(:new).with(strategy, file).and_return(product_import_strategy)
        allow(product_import_strategy).to receive(:execute).and_return(success: false, message: 'Import error')
        allow(Rails.logger).to receive(:error)
      end

      it 'logs an error message' do
        expect(Rails.logger).to receive(:error).with('Failed to import products: Import error')
        subject.perform(strategy, file)
      end
    end
  end
end
