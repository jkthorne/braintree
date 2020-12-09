class Braintree::Models::PageInfo
  include JSON::Serializable

  @[JSON::Field(key: "hasNextPage")]
  property has_next_page : Bool

  @[JSON::Field(key: "startCursor")]
  property start_cursor : String

  @[JSON::Field(key: "endCursor")]
  property end_cursor : String
end
