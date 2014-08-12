# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-edmodo/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-edmodo"
  spec.version       = Omniauth::Edmodo::VERSION
  spec.authors       = ["Jerry Luk"]
  spec.email         = ["jerryluk@gmail.com"]
  spec.summary       = %q{OmniAuth strategy for Edmodo}
  spec.description   = %q{OmniAuth strategy for Edmodo}
  spec.homepage      = "https://github.com/jerryluk/omniauth-edmodo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth'
  spec.add_dependency 'omniauth-oauth2'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "webmock"
end
