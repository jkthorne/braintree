module Braintree
  class GQLQueryResult
    include JSON::Serializable

    @[JSON::Field(key: "data")]
    property data : Data
    @[JSON::Field(key: "extensions")]
    property extensions : Models::Extensions

    class Data
      include JSON::Serializable

      class Search
        include JSON::Serializable
      end

      @[JSON::Field(key: "search")]
      property search : Search
    end

  end
end

require "./models/**"
