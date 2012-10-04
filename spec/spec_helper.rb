require 'rubygems'
require 'bundler'
Bundler.require(:default, :development)

require 'guard/zeus-client'

RSpec.configure do |config|
  config.filter_run :focus => true
  config.alias_example_to :fit, :focus => true
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.color_enabled = true
end
