class Braintree::Models::TransactionData
  include JSON::Serializable

  class Search
    include JSON::Serializable

    @[JSON::Field(key: "transactions")]
    property transactions : Transactions
  end

  @[JSON::Field(key: "search")]
  property search : Search
end
