module Fog
  module Compute
    class CloudSigma
      class Real
        def get_server(identifier)
          return nil if identifier.nil? || identifier == ""
          request( :get, "/guests/#{identifier}/info")
        end
      end

      class Mock
        def get_server(identifier)
          return nil if identifier.nil? || identifier == ""
          response = Excon::Response.new
          response.status = [200, 203][rand(1)]
          response.body = {
            "status"=>"stopped",
            "name"=>"Virtual Machine number 1",
            "mem"=>"7424",
            "vnc:password"=>"password",
            "description"=>"A CloudSigma Virtual Machine",
            "boot"=>"ide:0:0",
            "persistent"=>"true",
            "server"=>"aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
            "nic:0:dhcp"=>"auto",
            "vnc:ip"=>"auto",
            "cpu"=>"2000",
            "user"=>"aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"}
          response
        end
      end
    end
  end
end
