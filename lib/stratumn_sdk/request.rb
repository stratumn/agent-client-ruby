require 'http'

module StratumnSdk
  module Request

    def get(*args)
      request(:get, *args)
    end

    def post(*args)
      result = request(:post, *args)

      raise result['meta']['errorMessage'] if result['meta'] && result['meta']['errorMessage']

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
