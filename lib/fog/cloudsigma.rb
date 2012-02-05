require(File.expand_path(File.join(File.dirname(__FILE__), 'core')))

module Fog
  module CloudSigma
    extend Fog::Provider
    service(:compute, 'cloudsigma/compute', 'Compute')

    class Mock
      # def self.etag
      #   Fog::Mock.random_hex(32)
      # end
    end
  end
end
