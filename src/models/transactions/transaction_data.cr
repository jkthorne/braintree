class Braintree::Models::TransactionData
  include JSON::Serializable

  class ChargePaymentMethod
    include JSON::Serializable

    @[JSON::Field(key: "transaction")]
    property transaction : Models::Transaction
  end

  @[JSON::Field(key: "chargePaymentMethod")]
  property charge_payment_method : ChargePaymentMethod
end
