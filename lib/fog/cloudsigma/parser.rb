module Fog
  module CloudSigma
    class Parser
      attr_accessor :response

      def reset
        @response = {}
      end

      def parse data
        reset

        data.scan(/([^ \n]+) (.*)/).each do |key, value|
          @response[key] = value
        end

        @response
      end
    end
  end
end
