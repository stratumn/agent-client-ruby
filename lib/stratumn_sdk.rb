require 'stratumn_sdk/version'
require 'stratumn_sdk/request'
require 'stratumn_sdk/helper'
require 'stratumn_sdk/application'
require 'stratumn_sdk/link'

require 'yaml'

module StratumnSdk

  # Configuration defaults
  @config = {
              base_url: 'https://stratumn.rocks',
              application_url: 'https://%s.stratumn.rocks'
            }

  @valid_config_keys = @config.keys

  # Configure through hash
  def self.configure(opts = {})
    opts.each {|k,v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
  end

  # Configure through yaml file
  def self.configure_with(path_to_yaml_file)
    begin
      config = YAML::load(IO.read(path_to_yaml_file))
    rescue Errno::ENOENT
      log(:warning, "YAML configuration file couldn't be found. Using defaults."); return
    rescue Psych::SyntaxError
      log(:warning, "YAML configuration file contains invalid syntax. Using defaults."); return
    end

    configure(config)
  end

  def self.config
    @config
  end
end
