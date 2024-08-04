module ApiImporter
  class FetchProducts
    include Interactor::Organizer

    organize ApiImporter::FetchFromApi, ApiImporter::ParseResponse, ApiImporter::SaveProducts
  end
end
