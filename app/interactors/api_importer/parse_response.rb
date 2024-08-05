# frozen_string_literal: true

module ApiImporter
  # Class to define interactor
  class ParseResponse
    include Interactor

    def call
      context.products = JSON.parse(context.response.body)
    rescue JSON::ParserError => e
      context.fail!(message: "Failed to parse response, #{e}")
    end
  end
end
