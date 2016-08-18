# Copyright (C) 2017  Stratumn SAS
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

module StratumnSdk
  ##
  # Represents a Stratumn application
  class Application
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
      result = post(url + '/maps', json: args)

      Link.new(self, result)
    end

    def get_link(link_hash)
      result = get(url + '/links/' + link_hash)

      Link.new(self, result)
    end

    def get_map(map_id, tags = [])
      query = tags.empty? ? '' : "?tags=#{tags.join('&tags=')}"

      result = get(url + '/maps/' + map_id + query)

      result.map do |link|
        Link.new(self, link)
      end
    end

    def get_branches(link_hash, tags = [])
      query = tags.empty? ? '' : "?tags=#{tags.join('&tags=')}"

      result = get(url + '/branches/' + link_hash + query)

      result.map do |link|
        Link.new(self, link)
      end
    end
  end
end
