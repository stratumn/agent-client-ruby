# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stratumn_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = "stratumn_sdk"
  spec.version       = StratumnSdk::VERSION
  spec.authors       = ["Stratumn Team"]
  spec.email         = ["stratumn@gmail.com"]

  spec.summary       = %q{Interact with your Stratumn agent from your ruby application}
  spec.homepage      = "https://github.com/stratumn/stratumn-sdk-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.1"

  spec.add_dependency "http", "~>2.0.3"
end

