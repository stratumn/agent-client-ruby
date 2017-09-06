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

    attr_accessor :processes
    attr_reader :url

    def self.load(url)
      result = get(url)
      instance = new(url)

      process_list = result['processes']
      raise('Agent has not sent the processes') if process_list.nil?

      if process_list.respond_to?('each')
        process_list.each do |pname, pcontent|
          instance.add_new_process(pname, pcontent)
        end
      end
      instance
    end

    def initialize(url)
      @url = url
      @processes = {}
    end

    def add_new_process(name, content)
      process = Process.new(url,
                            name,
                            content['processInfo'],
                            content['storeInfo'])
      processes[name] = process
    end
  end
end
