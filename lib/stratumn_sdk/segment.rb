module StratumnSdk
  ##
  # Represents a link in a Stratumn application
  class Segment
    include Request
    include Helper

    attr_accessor :agent, :meta, :state, :link, :link_hash

    def initialize(agent, obj)
      self.agent = agent

      self.link = obj['link']
      self.meta = link['meta']
      self.state = link['state']
      self.link_hash = obj['meta']['linkHash']

      agent.agent_info['functions'].each do |(method, _)|
        add_transition_method(method)
      end
    end

    def previous
      agent.get_segment(meta['prevLinkHash']) if meta['prevLinkHash']
    end

    def get_branches(tags)
      agent.get_branches(link_hash, tags)
    end

    def load
      agent.get_segment(link_hash)
    end

    def self.load(segment)
      meta = segment['meta']

      agent = Agent.load(
        meta['agentUrl'],
        meta['applicationLocation']
      )

      agent.get_segment(meta['linkHash'])
    end

    private

    def add_transition_method(method)
      define_singleton_method(method) do |*args|
        url = "#{agent.url}/segments/#{link_hash}/#{method}"

        result = post(url, json: args)

        self.class.new(agent, result)
      end

      singleton_class.send(:alias_method, underscore(method), method)
    end
  end
end
