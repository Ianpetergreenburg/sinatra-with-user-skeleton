require 'rubygems'

# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.
ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'shoulda-matchers'
require 'rack/test'
require 'capybara'
require 'capybara/rspec'
require 'rspec-html-matchers'
require 'database_cleaner'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RSpecHtmlMatchers


  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

def app
  Sinatra::Application
end

Capybara.app = app.new

def session
  last_request.env['rack.session']
end
