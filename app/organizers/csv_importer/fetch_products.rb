# frozen_string_literal: true

module CsvImporter
  # Class to define organizer
  class FetchProducts
    include Interactor::Organizer

    organize CsvImporter::InitializeSpreadsheet, CsvImporter::ProcessRows, CsvImporter::FindOrInitializeProduct,
             CsvImporter::UpdateProduct
  end
end
