# frozen_string_literal: true

require 'roo'

module CsvImporter
  # Class to define interactor
  class InitializeSpreadsheet
    include Interactor

    def call
      file = context.file
      context.spreadsheet = Roo::Spreadsheet.open(file)
      context.header = context.spreadsheet.row(1)
    rescue StandardError => e
      context.fail!(message: "Failed to initialize spreadsheet: #{e.message}")
    end
  end
end
