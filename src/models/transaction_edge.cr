class Braintree::Models::TransactionEdge
  include JSON::Serializable

  @[JSON::Field(key: "node")]
  property node : Transaction
end
