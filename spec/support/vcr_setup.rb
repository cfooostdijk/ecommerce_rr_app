# frozen_string_literal: true

require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = { re_record_interval: 7.days }
  config.allow_http_connections_when_no_cassette = true
end

WebMock.disable_net_connect!(allow_localhost: true)
