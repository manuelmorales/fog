require File.expand_path(File.join(File.dirname(__FILE__), '..', 'cloudsigma'))
require 'fog/compute'
require 'fog/cloudsigma/parser'
require 'fog/cloudsigma/connection'

module Fog
  module Compute
    class CloudSigma < Fog::Service
      requires :http_login, :http_password

      request_path 'fog/cloudsigma/requests'
      request :get_server

      class Mock
      end

      class Real
        # Initialize connection to CloudSigma
        #
        # ==== Notes
        # options parameter must include values for :http_login and
        # :http_password in order to create a connection
        #
        # ==== Examples
        #  connection = Fog::Compute.new({
        #    :http_login    => "fake@sample.com",
        #    :http_password => "secret"
        #  })
        #
        # ==== Parameters
        #
        # ==== Returns
        # * Server object with connection to CloudSigma.
        def initialize(options={})
          require 'fog/core/parser'

          @http_login = options[:http_login]
          @http_password = options[:http_password]
          @persistent = false
          @connection_options = options[:connection_options] || {}

          @endpoint = options[:endpoint] || 'https://api.zrh.cloudsigma.com/'
          endpoint = URI.parse(@endpoint)
          @host = endpoint.host
          @path = endpoint.path
          @port = endpoint.port
          @scheme = endpoint.scheme

          @connection = Fog::CloudSigma::Connection.new("#{@scheme}://#{@host}:#{@port}#{@path}", @persistent, @connection_options)
        end

        def reload
          @connection.reset
        end

        private

        def request(method, path)
          http_auth = "#{@http_login}:#{@http_password}"
          encoded_auth = Base64.encode64(http_auth).chomp

          response = @connection.request({
            :path => path,
            :expects => 200,
            :method => method.to_s.upcase,
            :parser => Fog::CloudSigma::Parser.new,
            :body => nil,
            :headers => { 
              'Content-Type' => 'text/plain',
              'Authorization' => "Basic #{encoded_auth}"
            },
          })

          response
        end
      end
    end
  end
end
