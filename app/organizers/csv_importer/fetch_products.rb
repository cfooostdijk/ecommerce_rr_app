module CsvImporter
  class FetchProducts
    include Interactor::Organizer

    organize CsvImporter::InitializeSpreadsheet, CsvImporter::ProcessRows, CsvImporter::FindOrInitializeProduct, CsvImporter::UpdateProduct
  end
end
