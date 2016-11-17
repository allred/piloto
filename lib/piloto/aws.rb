require 'bundler/setup'
require 'aws-sdk'

module Piloto
  class Paws 
    #include Aws
    def dynamo 
      Aws::DynamoDB::Client.new(region: 'us-east-1')
    end
  end
end
