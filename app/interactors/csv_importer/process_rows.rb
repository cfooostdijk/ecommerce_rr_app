module CsvImporter
  class ProcessRows
    include Interactor

    def call
      rows = []
      normalized_header = context.header.map(&:downcase)
      (2..context.spreadsheet.last_row).each do |i|
        row = Hash[[normalized_header, context.spreadsheet.row(i)].transpose]
        rows << row
      end
      context.rows = rows
    rescue StandardError => e
      context.fail!(message: "Failed to process rows: #{e.message}")
    end
  end
end
