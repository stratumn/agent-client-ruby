# Copyright 2017 Stratumn SAS. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
