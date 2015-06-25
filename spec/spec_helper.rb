require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'simplecov'
SimpleCov.start 'rails'

require 'bundler/setup'
Bundler.require(:default, :development)

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.filter_run_excluding perf: true
  config.order = 'random'
  config.include FactoryGirl::Syntax::Methods
end

require_relative 'factories.rb'
