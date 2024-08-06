# frozen_string_literal: true

require 'rails_helper'
require 'roo'

RSpec.describe CsvImporter::InitializeSpreadsheet, type: :interactor do
  describe '.call' do
    let(:file) { double('file') }
    let(:spreadsheet) { instance_double('Roo::Excelx') }
    let(:context) { Interactor::Context.new(file:) }

    before do
      allow(Roo::Spreadsheet).to receive(:open).with(file).and_return(spreadsheet)
      allow(spreadsheet).to receive(:row).with(1).and_return(%w[header1 header2])
    end

    context 'when initialization is successful' do
      it 'sets the spreadsheet in the context' do
        result = described_class.call(context)
        expect(result.spreadsheet).to eq(spreadsheet)
      end

      it 'sets the header in the context' do
        result = described_class.call(context)
        expect(result.header).to eq(%w[header1 header2])
      end
    end

    context 'when initialization fails' do
      before do
        allow(Roo::Spreadsheet).to receive(:open).with(file).and_raise(StandardError, 'Initialization error')
      end

      it 'fails the context with an error message' do
        result = described_class.call(context)
        expect(result).to be_failure
        expect(result.message).to eq('Failed to initialize spreadsheet: Initialization error')
      end
    end
  end
end
