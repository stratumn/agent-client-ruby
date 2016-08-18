module StratumnSdk
  ##
  # Represents a Stratumn application
  class Agent
    include Request
    extend Request

    attr_accessor :url, :id, :name, :agent_info

    def self.load(application_name, application_location = nil)
      url = application_location ||
            StratumnSdk.config[:application_url].gsub('%s', application_name)
      attributes = get(url)

      new(url,
          attributes['id'],
          attributes['name'],
          attributes['agentInfo'])
    end

    def initialize(url, id, name, agent_info)
      self.url = url
      self.id = id
      self.name = name
      self.agent_info = agent_info
    end

    def create_map(*args)
      result = post(url + '/segments', json: args)

      Segment.new(self, result)
    end

    def get_segment(link_hash)
      result = get(url + '/segments/' + link_hash)

      Segment.new(self, result)
    end

    def get_map(map_id, tags = [])
      query = tags.empty? ? '' : "?tags=#{tags.join('&tags=')}"

      result = get(url + '/maps/' + map_id + query)

      result.map do |link|
        Segment.new(self, link)
      end
    end

    def get_branches(link_hash, tags = [])
      query = tags.empty? ? '' : "?tags=#{tags.join('&tags=')}"

      result = get(url + '/branches/' + link_hash + query)

      result.map do |link|
        Segment.new(self, link)
      end
    end
  end
end
