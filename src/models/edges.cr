class Braintree::Models::Edges
  include JSON::Serializable

  class Node
    include JSON::Serializable

    class Amount
      include JSON::Serializable

      @[JSON::Field(key: "value")]
      property value : String
      @[JSON::Field(key: "currencyIsoCode")]
      property currency_iso_code : String
    end

    @[JSON::Field(key: "id")]
    property id : String
    @[JSON::Field(key: "status")]
    property status : String
    @[JSON::Field(key: "amount")]
    property amount : Amount
  end

  @[JSON::Field(key: "node")]
  property node : Node
end
