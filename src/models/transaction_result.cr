module Braintree::Models
  class TransactionResult < GQLQueryResult
    class Data::Search
      include JSON::Serializable

      @[JSON::Field(key: "transactions")]
      property transactions : Models::Transactions
    end
  end
end