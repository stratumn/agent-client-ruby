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

require 'spec_helper'

require 'agent_client'

describe AgentClient::Agent, :vcr do
  describe '.load' do
    it 'loads an existing agent' do
      agent = described_class.load('http://localhost:3333')

      expect(agent.list_processes.map(&:process_name)).to(
        include('first_process')
      )
    end

    it 'raises for agent not found' do
      expect { described_class.load('http://not-found') }.to(
        raise_exception(StandardError)
      )
    end
  end
end
