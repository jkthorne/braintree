module Braintree
  class Mutation
    def to_gql
      JSON.build do |json|
        json.object do
          json.field "query", query_string
          json.field "variables" do
            json.object do
              variables_builder(json)
            end
          end
        end
      end
    end
  end

  class Operation
    getter request : HTTP::Request
    getter response : HTTP::Client::Response?

    def initialize
      @request = HTTP::Request.new
      raise "cannot initilaize this base class"
    end

    def success?
      response.try &.success?
    end

    def self.exec(*args, **kargs)
      new(*args, **kargs).exec do |op, tx|
        yield op, tx
      end
    end

    def exec
      response = Braintree.http.exec(@request)
      @response = response
      yield self, response.success? ? XML.parse(response.body) : nil
    end
  end
end

require "./operations/**"
