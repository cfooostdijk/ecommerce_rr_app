# frozen_string_literal: true

module ApiImporter
  # Class to define organizer
  class FetchProducts
    include Interactor::Organizer

    organize ApiImporter::FetchFromApi, ApiImporter::ParseResponse, ApiImporter::SaveProducts
  end
end
