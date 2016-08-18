require 'spec_helper'

require 'stratumn_sdk'

describe StratumnSdk::Agent, :vcr do
  describe '.load' do
    it 'loads an existing agent' do
      agent = described_class.load('http://localhost:3333')

      expect(agent.agent_info).to include('actions')
      expect(agent.store_info).to include('adapter')
    end

    it 'raises for agent not found' do
      expect { described_class.load('http://not-found') }.to(
        raise_exception(StandardError)
      )
    end
  end

  let(:agent) { described_class.load('http://localhost:3333') }

  describe '#create_map' do
    it 'creates a new map' do
      segment = agent.create_map('Test')

      expect(segment.state['title']).to eq('Test')
    end

    it 'handles error' do
      expect { agent.create_map }.to raise_exception(StandardError)
    end
  end

  describe '#find_segments' do
    context 'with no options' do
      it 'finds the segments' do
        2.times { agent.create_map('hi') }

        segments = agent.find_segments

        expect(segments.length).to eq(2)
      end
    end

    context 'with options' do
      it 'applies the options' do
        segment = agent.create_map('hi')

        result = agent.find_segments(mapId: segment.link['meta']['mapId'])

        expect(result.length).to eq(1)
        expect(result.first.link_hash).to eq(segment.link_hash)
      end
    end

    it 'returns loadable segments' do
      agent.create_map('hi')
      segments = agent.find_segments

      segments.each do |segment|
        expect(segment.methods).to include(:previous)
      end
    end
  end

  describe '#get_map_ids' do
    it 'gets map ids' do
      3.times { agent.create_map('hi') }
      map_ids = agent.get_map_ids

      expect(map_ids.length).to eq(3)
      expect(map_ids).to all(be_a(String))
    end
  end

  describe '#get_segment' do
    it 'gets a segment' do
      segment = agent.create_map('hi')

      result = agent.get_segment(segment.link_hash)

      expect(result.link_hash).to eq(segment.link_hash)
    end

    it 'rejects if the segment is not found' do
      expect { agent.get_segment('404') }.to raise_exception(StandardError)
    end
  end
end
