# Copyright (C) 2017  Stratumn SAS
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

module AgentClient
  ##
  # Represents a Stratumn agent
  class Agent
    include Request
    extend Request

    attr_accessor :url, :agent_info, :store_info

    def self.load(url)
      attributes = get(url)

      new(url,
          attributes['agentInfo'],
          attributes['storeInfo'])
    end

    def initialize(url, agent_info, store_info)
      self.url = url
      self.agent_info = agent_info
      self.store_info = store_info
    end

    def create_map(*args)
      result = post(url + '/segments', json: args)

      Segment.new(self, result)
    end

    def get_map_ids(options = {})
      get(url + '/maps?' + URI.encode_www_form(options))
    end

    def find_segments(options = {})
      result = get(url + '/segments?' + URI.encode_www_form(options))

      result.map do |link|
        Segment.new(self, link)
      end
    end

    def get_segment(link_hash)
      result = get(url + '/segments/' + link_hash)

      Segment.new(self, result)
    end
  end
end