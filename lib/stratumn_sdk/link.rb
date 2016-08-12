module StratumnSdk
  class Link
    include Request
    include Helper

    attr_accessor :application, :meta, :state, :link, :linkHash

    def initialize(application, obj)
      self.application = application

      self.link = obj['link']
      self.meta = link['meta']
      self.state = link['state']
      self.linkHash = obj['meta']['linkHash']

      application.agent_info['functions'].each do |(method, _)|
        define_singleton_method(method) do |*args|

          url = "#{application.url}/links/#{linkHash}/#{method}"

          result = post(url, json: args)

          Link.new(application, result)
        end

        singleton_class.send(:alias_method, underscore(method), method)
      end
    end

    def previous
      application.get_link(meta['prevLinkHash']) if meta['prevLinkHash']
    end

    def get_branches(tags)
      application.get_branches(linkHash, tags)
    end

    def load
      application.get_link(linkHash)
    end

    def self.load(segment)
      meta = segment['meta']

      application = Application.load(meta['application'], meta['applicationLocation'])

      application.get_link(meta['linkHash'])
    end
  end
end
