module Braintree::Models
  class TransactionSearchResult < GQLQueryResult
    @[JSON::Field(key: "data")]
    property data : TransactionSearchData
  end
end