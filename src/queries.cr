module Braintree
  class Query
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

    def self.exec(*args, **kargs)
      new(*args, **kargs).exec do |op, tx|
        yield op, tx
      end
    end
  end
end

require "./queries/**"
