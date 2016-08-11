# -*- ruby -*-

require "rubygems"
require "hoe"

# Hoe.plugin :compiler
# Hoe.plugin :gem_prelude_sucks
# Hoe.plugin :inline
# Hoe.plugin :minitest
# Hoe.plugin :racc
# Hoe.plugin :rcov
# Hoe.plugin :rdoc
# Hoe.plugin :gemspec
Hoe.plugin :git
Hoe.plugin :bundler

Hoe.spec "stratumn_sdk" do
  developer("Stratumn Team", "stratumn@gmail.com")

  dependency('hoe-bundler', '~> 1.3.0', :dev)
  dependency('http', '~> 2.0.3')
  dependency('rspec', '~> 3.5.0', :dev)
  dependency('vcr', '~> 3.0.3', :dev)
  dependency('webmock', '~> 2.1.0', :dev)

  license "MIT"
end

# vim: syntax=ruby
