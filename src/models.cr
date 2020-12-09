module Braintree
  class GQLQueryResult
    include JSON::Serializable

    @[JSON::Field(key: "extensions")]
    property extensions : Models::Extensions
  end
end

require "./models/**"
