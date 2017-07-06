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

require 'agent_client/version'
require 'agent_client/request'
require 'agent_client/helper'
require 'agent_client/agent'
require 'agent_client/segment'

require 'yaml'

##
# Allows interacting with your Stratumn agent from your ruby app
module AgentClient
  # Configuration defaults
  @config = {
    base_url: 'https://stratumn.rocks',
    application_url: 'https://%s.stratumn.rocks'
  }

  @valid_config_keys = @config.keys

  # Configure through hash
  def self.configure(opts = {})
    opts.each do |k, v|
      @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym
    end
  end

  # Configure through yaml file
  def self.configure_with(path_to_yaml_file)
    begin
      config = YAML.load(IO.read(path_to_yaml_file))
    rescue Errno::ENOENT
      puts 'YAML configuration file couldn\'t be found. Using defaults.'
      return
    rescue Psych::SyntaxError
      puts 'YAML configuration file contains invalid syntax. Using defaults.'
      return
    end

    configure(config)
  end

  def self.config
    @config
  end
end
