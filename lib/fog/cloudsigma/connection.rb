module Fog
  module CloudSigma
    class Connection < Fog::Connection
      def request(params, &block)
        unless @persistent
          reset
        end

        response = @excon.request(params, &block)

        if parser = params.delete(:parser)
          response.body = parser.parse(response.body)
        end

        response
      end
    end
  end
end
