# frozen_string_literal: true

module CsvImporter
  # Class to define interactor
  class ProcessRows
    include Interactor

    def call
      context.rows = process_rows
    rescue StandardError => e
      context.fail!(message: "Failed to process rows: #{e.message}")
    end

    private

    def process_rows
      header = normalize_header
      fetch_rows.map { |row| create_row_hash(header, row) }
    end

    def normalize_header
      context.header.map(&:downcase)
    end

    def fetch_rows
      (2..context.spreadsheet.last_row).map do |i|
        context.spreadsheet.row(i)
      end
    end

    def create_row_hash(header, row)
      Hash[[header, row].transpose]
    end
  end
end
