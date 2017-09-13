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
  let(:process) { agent.get('first_process') }

  describe '#find_segments' do
    context 'with no options' do
      it 'finds the segments' do
        2.times { process.create_map('hi') }

        segments = process.find_segments

        expect(segments.length).to eq(2)
      end
    end

    context 'with options' do
      it 'applies the options' do
        segment = process.create_map('hi')

        result = process.find_segments(mapId: segment.link['meta']['mapId'])

        expect(result.length).to eq(1)
        expect(result.first.link_hash).to eq(segment.link_hash)
      end
    end

    it 'returns loadable segments' do
      process.create_map('hi')
      segments = process.find_segments

      segments.each do |segment|
        expect(segment.methods).to include(:previous)
      end
    end
  end
end
