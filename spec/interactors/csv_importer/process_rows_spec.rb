# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CsvImporter::ProcessRows, type: :interactor do
  describe '.call' do
    let(:spreadsheet) { instance_double('Roo::Excelx') }
    let(:context) { Interactor::Context.new(header: %w[Header1 Header2], spreadsheet:) }

    before do
      allow(spreadsheet).to receive(:last_row).and_return(3)
      allow(spreadsheet).to receive(:row).with(2).and_return(%w[Value1 Value2])
      allow(spreadsheet).to receive(:row).with(3).and_return(%w[Value3 Value4])
    end

    context 'when processing is successful' do
      it 'sets the rows in the context' do
        result = described_class.call(context)
        expected_rows = [
          { 'header1' => 'Value1', 'header2' => 'Value2' },
          { 'header1' => 'Value3', 'header2' => 'Value4' }
        ]
        expect(result.rows).to eq(expected_rows)
      end
    end

    context 'when processing fails' do
      before do
        allow(spreadsheet).to receive(:last_row).and_raise(StandardError, 'Processing error')
      end

      it 'fails the context with an error message' do
        result = described_class.call(context)
        expect(result).to be_failure
        expect(result.message).to eq('Failed to process rows: Processing error')
      end
    end
  end
end
