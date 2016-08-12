require 'http'

module StratumnSdk
  ##
  # Wrapper around HTTP.request that parses the response and raises on error
  module Request
    def get(*args)
      request(:get, *args)
    end

    def post(*args)
      result = request(:post, *args)

      if result['meta'] && result['meta']['errorMessage']
        raise result['meta']['errorMessage']
      end

      result
    end

    private

    def request(verb, *args)
      result = HTTP.request(verb, *args).parse

      raise result['error'] if result.is_a?(Hash) && result['error']

      result
    end
  end
end
