require 'fog/vcloud/models/compute/servers'

Shindo.tests("Vcloud::Compute | servers", ['vcloud']) do

  Fog::Vcloud::Compute::SUPPORTED_VERSIONS.each do |version|
    tests("api version #{version}") do
      instance = Fog::Vcloud::Compute::Servers.new(
        :connection => Fog::Vcloud::Compute.new(
          :vcloud_host => 'vcloud.example.com',
          :vcloud_username => 'username',
          :vcloud_password => 'password',
          :vcloud_version => version),
        :href       =>  "https://vcloud.example.com/api#{(version == '1.0') ? '/v1.0' : ''}/vApp/vapp-1"
      )
    
      tests("collection") do
        returns(2) { instance.size }
        returns("https://vcloud.example.com/api#{(version == '1.0') ? '/v1.0' : ''}/vApp/vm-2") { instance.first.href }
      end
    end
  end
end
