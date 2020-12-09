module Braintree
  class Ping < Query
    def self.to_gql
      super do |io|
        io << "ping"
      end
    end
  end  
end
