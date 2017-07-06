# Copyright 2017 Stratumn SAS. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
