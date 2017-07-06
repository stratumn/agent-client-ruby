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

describe AgentClient::Segment, :vcr do
  let(:app) { AgentClient::Agent.load('http://localhost:3333') }
  let(:segment) { app.get_segment(link_hash) }
  let(:link_hash) { app.create_map('blah').link_hash }

  describe '.initialize' do
    it 'adds functions for agent methods' do
      new_segment = segment.addMessage('Hello, World!', 'Stratumn')

      expect(new_segment.state['messages'].first['message']).to(
        eq('Hello, World!')
      )
      expect(new_segment.state['messages'].first['author']).to eq('Stratumn')
    end

    it 'aliases transition functions with camel case version' do
      expect(segment).to respond_to(:add_message)
    end
  end

  describe '.from' do
    let(:raw_segment) do
      JSON.parse(
        File.read(File.expand_path('../../fixtures/segment.json', __FILE__))
      )
    end

    it 'loads the full link' do
      segment = described_class.from(raw_segment)

      expect(segment.state['value']).to eq('one')
    end
  end

  describe '#previous' do
    it 'is null if first link' do
      expect(segment.previous).to be_nil
    end

    it 'returns the previous link if not first' do
      new_segment = segment.add_message('Hello, World!', 'Stratumn')

      expect(new_segment.previous.link_hash).to eq(segment.link_hash)
    end
  end

  describe '#find_segments' do
    it 'returns the segments' do
      segments = segment.find_segments

      expect(segments).to be_an(Array)
    end
  end

  describe '#load' do
    it 'loads the full segment' do
      expect(segment.load.state).not_to be_nil
    end
  end
end
