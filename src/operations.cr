module Braintree
  class Query
    def self.to_gql
      String.build do |str|
        str << "query { "
        yield str
        str << " }"
      end
    end
  end
end

require "./operations/*"
