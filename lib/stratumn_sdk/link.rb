module StratumnSdk
  ##
  # Represents a link in a Stratumn application
  class Link
    include Request
    include Helper

    attr_accessor :application, :meta, :state, :link, :link_hash

    def initialize(application, obj)
      self.application = application

      self.link = obj['link']
      self.meta = link['meta']
      self.state = link['state']
      self.link_hash = obj['meta']['linkHash']

      application.agent_info['functions'].each do |(method, _)|
        add_transition_method(method)
      end
    end

    def previous
      application.get_link(meta['prevLinkHash']) if meta['prevLinkHash']
    end

    def get_branches(tags)
      application.get_branches(link_hash, tags)
    end

    def load
      application.get_link(link_hash)
    end

    def self.load(segment)
      meta = segment['meta']

      application = Application.load(
        meta['application'],
        meta['applicationLocation']
      )

      application.get_link(meta['linkHash'])
    end

    private

    def add_transition_method(method)
      define_singleton_method(method) do |*args|
        url = "#{application.url}/links/#{link_hash}/#{method}"

        result = post(url, json: args)

        self.class.new(application, result)
      end

      singleton_class.send(:alias_method, underscore(method), method)
    end
  end
end
