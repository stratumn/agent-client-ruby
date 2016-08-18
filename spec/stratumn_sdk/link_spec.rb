require 'spec_helper'
require 'stratumn_sdk'

describe StratumnSdk::Link, :vcr do
  let(:app) { StratumnSdk::Agent.load('sdk-test') }
  let(:link_hash) do
    '9e16cda1745402d887ba89ccad3dc4bf9aafa86427aab2ca19bf42beb9d108ff'
  end
  let(:link) { app.get_link(link_hash) }

  describe '.initialize' do
    it 'adds functions for agent methods' do
      new_link = link.addMessage('Hello, World!')

      expect(new_link.state['messages'].first['content']).to eq('Hello, World!')
      expect(new_link.state['messages'].first['author']).to eq('Anonymous')
    end

    it 'aliases transition functions with camel case version' do
      expect(link).to respond_to(:add_message)
    end
  end

  describe '.load' do
    let(:segment) do
      JSON.parse(
        File.read(File.expand_path('../../fixtures/segment.json', __FILE__))
      )
    end

    it 'loads the full link' do
      link = described_class.load(segment)

      expect(link.state['title']).to eq('test')
    end
  end

  describe '#previous' do
    it 'is null if first link' do
      expect(link.previous).to be_nil
    end

    it 'returns the previous link if not first' do
      new_link = link.addMessage('Hello, World!')

      expect(new_link.previous.link_hash).to eq(link.link_hash)
    end
  end

  describe '#get_branches' do
    it 'returns the branches' do
      branches = link.get_branches(['test'])

      expect(branches.length).to eq(1)
    end
  end

  describe '#load', vcr: { cassette_name: '_class_load' } do
    it 'loads the full link' do
      map = app.get_map('57277b34b25789323e1099fc')

      expect(map.first.state).to be_nil
      expect(map.first.load.state['title']).to eq('test')
    end
  end
end
