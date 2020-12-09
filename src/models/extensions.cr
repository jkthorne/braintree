class Braintree::Models::Extensions
  include JSON::Serializable

  @[JSON::Field(key: "requestId")]
  property request_id : String
end
