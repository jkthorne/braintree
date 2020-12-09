class Braintree::Models::Transactions
  include JSON::Serializable

  @[JSON::Field(key: "pageInfo")]
  property page_info : PageInfo

  @[JSON::Field(key: "edges")]
  property edges : Array(TransactionEdge)
end
