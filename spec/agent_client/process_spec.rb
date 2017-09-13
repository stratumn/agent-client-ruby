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

describe AgentClient::Process, :vcr do
  let(:agent) { AgentClient::Agent.load('http://localhost:3333') }

  describe '.load' do
    it 'loads an existing process' do
      process = agent.get('first_process')

      expect(process.info).to include('actions')
      expect(process.store_info).to include('adapter')
    end

    it 'raises for process not found' do
      expect { described_class.load('http://not-found', 'process_name') }.to(
        raise_exception(StandardError)
      )
    end
  end

  let(:process) { agent.get('first_process') }

  describe '#create_map' do
    it 'creates a new map' do
      segment = process.create_map('Test')

      expect(segment.state['title']).to eq('Test')
    end

    it 'handles error' do
      expect { process.create_map }.to raise_exception(StandardError)
    end
  end

  describe '#get_map_ids' do
    it 'gets map ids' do
      3.times { process.create_map('hi') }
      map_ids = process.get_map_ids

      expect(map_ids.length).to eq(3)
      expect(map_ids).to all(be_a(String))
    end
  end

  describe '#get_segment' do
    it 'gets a segment' do
      segment = process.create_map('hi')

      result = process.get_segment(segment.link_hash)

      expect(result.link_hash).to eq(segment.link_hash)
    end

    it 'rejects if the segment is not found' do
      expect { process.get_segment('404') }.to raise_exception(StandardError)
    end
  end
end
