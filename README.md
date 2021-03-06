# Agent client for Ruby

[![build status](https://travis-ci.org/stratumn/agent-client-ruby.svg?branch=master)](https://travis-ci.org/stratumn/agent-client-ruby.svg?branch=master)
[![Gem Version](https://badge.fury.io/rb/stratumn_agent_client.svg)](https://badge.fury.io/rb/stratumn_agent_client)

Interact with your Indigo agent from your ruby code.

code :: https://github.com/stratumn/agent-client-ruby

## Installation

Add this line to your agent's Gemfile:

```ruby
gem 'indigoframework_agent_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install indigoframework_agent_client

## Quickstart

```ruby
agent = AgentClient::Agent.load('http://localhost:3000')

raise 'No process detected in Agent' if agent.list_processes.empty?

process = agent.get('process_name')

segment = process.create_map('My message map')

segment = segment.add_message('Hello, World', 'POTUS')

puts segment.meta
puts segment.state
```

## Reference

#### AgentClient::Agent.load(url)

Returns an instance of AgentClient::Agent containing several processes

```ruby
agent = AgentClient::Agent.load('http://localhost:3000')
puts agent.list_processes()
```

#### AgentClient::Process#create_map(references, \*args)

Creates a new map in the agent.

```ruby
agent = AgentClient::Agent.load('http://localhost:3000')
process = agent.get('process_name')
segment = process.create_map([], 'My message map')
```

#### AgentClient::Agent.get_segment(hash)

Returns an existing segment.

```ruby
agent = AgentClient::Agent.load('http://localhost:3000')
process = agent.get('process_name')
segment = process.get_segment('aee5427')
puts segment.link_hash
```

#### AgentClient::Agent.find_segments(options = {})

Returns existing segments.

Available options are:

* `offset`: offset of first returned segments
* `limit`: limit number of returned segments
* `mapIds`: return segments with one of the specified map IDs
* `prevLinkHash`: return segments with specified previous link hash
* `tags`: return segments that contains all the tags (array)

```ruby
agent = AgentClient::Agent.load('http://localhost:3000')
process = agent.get('process_name')
segments = process.find_segments(tags: ['tag1', 'tag2'])
segments = process.find_segments(limit: 10)
```

#### AgentClient::Segment.from

Returns segment from a given raw object.

```ruby
segment = AgentClient::Segment.from(raw_segment)
puts segment.process
puts segment.link_hash
```

#### AgentClient::Segment#previous

Returns the previous segment of a segment (its parent).

```ruby
agent = AgentClient::Agent.load('http://localhost:3000')
process = agent.get('process_name')
segment = process.get_segment('aee5427')
previous = segment.previous
```

#### AgentClient::Segment#load

Loads a full segment. Can be useful when you only have the meta data of links.

```ruby
agent = AgentClient::Agent.load('http://localhost:3000')
process = agent.get('process_name')
segments = process.find_segments

segments.map { |segment| segment.load }
```

#### AgentClient::Segment#transition_function(references, \*args)

Executes a transition function and returns the new segment.

```ruby
agent = AgentClient::Agent.load('http://localhost:3000')
process = agent.get('process_name')
segment = process.get_segment('aee5427')
new_segment = segment.addMessage([], 'Hello, World!')

# underscore version is also available
new_segment = segment.add_message([], 'Hello, World!')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Tests

Tests are run against a mock agent whose results are recorded by vcr.
Should you need to regenerate the cassettes or add new tests, the mock agent can be launched on port 3333.

```
$ cd spec/agent
$ npm install
$ node index.js
```
