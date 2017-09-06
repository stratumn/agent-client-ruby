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
  # Represents a Stratumn process
  class Process
    include Request
    extend Request

    attr_accessor :process_name, :process_url, :info, :store_info

    def initialize(url, process_name, process_info, store_info)
      self.process_name = process_name
      self.process_url = "#{url}/#{process_name}"
      self.info = process_info
      self.store_info = store_info
    end

    def create_map(*args)
      result = post(process_url + '/segments', json: args)

      Segment.new(self, result)
    end

    def get_map_ids(options = {})
      get(process_url + '/maps?' + URI.encode_www_form(options))
    end

    def find_segments(options = {})
      result = get(process_url + '/segments?' + URI.encode_www_form(options))

      result.map do |link|
        Segment.new(self, link)
      end
    end

    def get_segment(link_hash)
      result = get(process_url + '/segments/' + link_hash)

      Segment.new(self, result)
    end
  end
end
