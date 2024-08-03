class FetchProducts
  include Interactor::Organizer

  organize FetchFromApi, ParseResponse, SaveProducts
end
