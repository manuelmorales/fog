require 'spec_helper'

describe Fog::Compute::CloudSigma do
  def credentials_from_file credentials_file
    if File.exist?(credentials_file)
      YAML.load(File.read(credentials_file))
    else
      {}
    end
  end

  def credentials
    @credentials ||= {
      :http_login => "fake@sample.com",
      :http_password => "secret",
      :server_uuid => "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
    }.merge(credentials_from_file('spec/credentials.yml')[:cloudsigma])
  end

  before :each do
    @http_login = credentials[:http_login]
    @http_password = credentials[:http_password]
  end

  def do_new
    Fog::Compute.new({
      :provider      => 'cloudsigma',
      :http_login    => @http_login,
      :http_password => @http_password
    })
  end

  it 'should create a new instance' do
    lambda{ do_new }.should_not raise_exception
  end

  it 'should implement get_server' do
    lambda{ do_new.get_server(credentials[:server_uuid]).body }.should_not raise_exception
  end
end
