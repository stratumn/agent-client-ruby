require 'spec_helper'

require 'stratumn_sdk'

describe StratumnSdk::Agent, :vcr do
  describe '.get' do
    it 'loads an existing agent' do
      app = StratumnSdk::Agent.load('sdk-test')

      expect(app.name).to eq('sdk-test')
      expect(app.id).to eq('572778542311def814311315')
      expect(app.agent_info).to include('functions')
    end

    it 'raises for agent not found' do
      expect { StratumnSdk::Agent.get('not-found') }.to(
        raise_exception(StandardError)
      )
    end
  end

  let(:app) { StratumnSdk::Agent.load('sdk-test') }

  describe '#create_map' do
    it 'creates a new map' do
      segment = app.create_map('Test')

      expect(segment.state['title']).to eq('Test')
    end
  end

  describe '#get_segment' do
    it 'gets a segment' do
      segment = app.get_segment('9f0dec64d62e946ff8')

      expect(segment.state['title']).to eq('test')
    end
  end

  describe '#get_map' do
    it 'gets a map' do
      map = app.get_map('57277b34b25789323e1099fc')

      expect(map.length).to eq(3)
    end

    it 'can filter by tag' do
      map = app.get_map('57277b34b25789323e1099fc', %w(random test))

      expect(map.length).to eq(1)
    end

    it 'returns loadable segments' do
      map = app.get_map('57277b34b25789323e1099fc')

      map.each do |segment|
        expect(segment.methods).to include(:load)
      end
    end
  end

  describe '#get_branches' do
    it 'gets the branches' do
      branches = app.get_branches('9f0dec64d62e946ff8')

      expect(branches.length).to eq(3)
    end

    it 'can filter by tag' do
      branches = app.get_branches('1fb63515f8e', %w(random test))

      expect(branches.length).to eq(1)
    end

    it 'returns loadable segments' do
      branches = app.get_branches('9f0dec64d62e946ff8')

      branches.each do |segment|
        expect(segment.methods).to include(:load)
      end
    end
  end
end
