class Braintree::Models::TransactionSearchData
  include JSON::Serializable

  class Search
    include JSON::Serializable

    @[JSON::Field(key: "transactions")]
    property transactions : Models::Transactions
  end

  @[JSON::Field(key: "search")]
  property search : Search
end
