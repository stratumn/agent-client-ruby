require 'spec_helper'

require 'stratumn_sdk'

describe StratumnSdk::Application, :vcr do

  describe '.get' do

    it 'loads an existing application' do
      app = StratumnSdk::Application.load('sdk-test')

      expect(app.name).to eq('sdk-test')
      expect(app.id).to eq('572778542311def814311315')
      expect(app.agent_info).to include('functions')
    end

    it 'raises for application not found' do
      expect { StratumnSdk::Application.get('not-found') }.to raise_exception
    end
  end

  let(:app) { StratumnSdk::Application.load('sdk-test') }

  describe '#create_map' do

    it 'creates a new map' do
      link = app.create_map('Test')

      expect(link.state['title']).to eq('Test')
    end
  end

  describe '#get_link' do

    it 'gets a link' do
      link = app.get_link('9f0dec64d62e946ff8')

      expect(link.state['title']).to eq('test')
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

    it 'returns loadable links' do
      map = app.get_map('57277b34b25789323e1099fc')

      map.each do |link|
        expect(link.methods).to include(:load)
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

    it 'returns loadable links' do
      branches = app.get_branches('9f0dec64d62e946ff8')

      branches.each do |link|
        expect(link.methods).to include(:load)
      end
    end
  end


end
