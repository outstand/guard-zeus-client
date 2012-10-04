source 'https://rubygems.org'

# Specify your gem's dependencies in ..gemspec
gemspec

group :development do
  gem 'rb-readline'

  require 'rbconfig'
  if RbConfig::CONFIG['target_os'] =~ /darwin/i
    gem 'rb-fsevent', '>= 0.3.2',  :require => false
  end
end
