require 'spec_helper'
require 'stratumn_sdk'

describe StratumnSdk::Segment, :vcr do
  let(:app) { StratumnSdk::Agent.load('http://localhost:3333') }
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
