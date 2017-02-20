# Copyright (C) 2017  Stratumn SAS
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'agent_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'stratumn_agent_client'
  spec.version       = AgentClient::VERSION
  spec.authors       = ['Stratumn Team']
  spec.email         = ['stratumn@gmail.com']

  spec.summary       = 'Interact with your Stratumn agent from your ruby app'
  spec.homepage      = 'https://github.com/stratumn/agent-client-ruby'
  spec.license       = 'MPL-2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 2.1'
  spec.add_development_dependency 'rubocop', '~> 0.42'

  spec.add_runtime_dependency 'http', '~> 2.0'
end
