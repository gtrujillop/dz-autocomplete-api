require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = [:json]
  config.docs_dir = Rails.root.join('public/docs')

  config.request_headers_to_include = ['Content-Type', 'Uid', 'Access-Token', 'Client', 'Token-Type', 'Expiry']
  config.curl_headers_to_filter = ['Cookie', 'Host']

  config.request_body_formatter = :json
end
