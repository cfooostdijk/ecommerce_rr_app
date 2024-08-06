# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/db/'
  add_filter '/spec/'
  add_filter '/app/mailer'
  add_filter '/app/channels/'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/controllers/catalog_controller.rb'
  add_filter 'app/controllers/homepage_controller.rb'
end
