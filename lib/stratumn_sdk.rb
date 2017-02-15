# Copyright (C) 2017  Stratumn SAS
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'stratumn_sdk/version'
require 'stratumn_sdk/request'
require 'stratumn_sdk/helper'
require 'stratumn_sdk/application'
require 'stratumn_sdk/link'

require 'yaml'

##
# Allows interacting with your Stratumn agent from your ruby app
module StratumnSdk
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
