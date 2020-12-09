module Braintree::Models
  class TransactionResult < GQLQueryResult
    @[JSON::Field(key: "data")]
    property data : TransactionData
  end
end