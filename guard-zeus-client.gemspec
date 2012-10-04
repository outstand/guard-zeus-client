# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/zeus-client/version'

Gem::Specification.new do |gem|
  gem.name          = "guard-zeus-client"
  gem.version       = Guard::ZeusClientVersion::VERSION
  gem.authors       = ["Ryan Schlesinger"]
  gem.email         = ["ryan@aceofsales.com"]
  gem.description   = %q{Guard::ZeusClient automatically runs a zeus command (test by default) when your files change.  Does not run zeus server.}
  gem.summary       = %q{Guard gem for Zeus}
  gem.homepage      = "https://github.com/aceofsales/guard-zeus-client"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'guard', '>= 1.1'
  gem.add_dependency 'zeus'

  gem.add_development_dependency 'rspec', '>= 2.11'
  gem.add_development_dependency 'guard-rspec'
end
