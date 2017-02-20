# Agent client for Ruby

[![build status](https://travis-ci.org/stratumn/agent-client-ruby.svg?branch=master)](https://travis-ci.org/stratumn/agent-client-ruby.svg?branch=master)
[![Gem Version](https://badge.fury.io/rb/stratumn_agent_client.svg)](https://badge.fury.io/rb/stratumn_agent_client)

Interact with your Stratumn agent from your ruby application

code  :: https://github.com/stratumn/agent-client-ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stratumn_agent_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stratumn_agent_client

## Quickstart

```ruby
application = AgentClient::Application.load('quickstart')

link = application.create_map('My message map')

link = link.addMessage('Hello, World')

puts link.meta
puts link.state
```

## Reference

#### AgentClient::Application.load(name)

Returns an instance of AgentClient::Application.

```ruby
application = AgentClient::Application.load('quickstart')
puts application.id
```

#### AgentClient::Application#create_map(*args)

Creates a new map in the application.

```ruby
application = AgentClient::Application.load('quickstart')
link = application.create_map('My message map')
```

#### AgentClient::Application.get_link(hash)

Returns an existing link.

```ruby
application = AgentClient::Application.load('quickstart')
link = application.get_link('aee5427')
puts link.link_hash
```

#### AgentClient::Application.get_map(map_id, tags = [])

Returns the links in a map, optionally filtered by tags.

```ruby
application = AgentClient::Application.load('quickstart')
links = application.get_map('aee5427', ['tag1', 'tag2'])
```

#### AgentClient::Application.get_branches(hash, tags = [])

Returns he links whose previous hashes are the given hash, optionally filters by tags.

```ruby
application = AgentClient::Application.load('quickstart')
links = application.get_branches('aee5427', ['tag1', 'tag2'])
```

#### AgentClient::Link#previous

Returns the previous link of a link (its parent).

```ruby
application = AgentClient::Application.load('quickstart')
link = application.get_link('aee5427')
previous = link.previous
```

#### AgentClient::Link#load

Loads a full link. Can be useful when you only have the meta data of links.

```ruby
application = AgentClient::Application.load('quickstart')
links = application.get_branches('aee5427')

links.map { |link| link.load }
```

#### AgentClient::Link#get_branches(tags)

Returns the links whose previous hashes are the hash of the link, optionally filters by tags.

```ruby
application = AgentClient::Application.load('quickstart')
link = application.get_link('aee5427')
link.get_branches(['tag1'])
```

#### AgentClient::Link#transition_function(*args)

Executes a transition function and returns the new link.

```ruby
application = AgentClient::Application.load('quickstart')
link = application.get_link('aee5427')
new_link = link.addMessage('Hello, World!')

# underscore version is also available
new_link = link.add_message('Hello, World!')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org)
