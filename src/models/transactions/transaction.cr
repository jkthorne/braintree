class Braintree::Models::Transaction
  include JSON::Serializable

  class Amount
    include JSON::Serializable

    @[JSON::Field(key: "value")]
    property value : String?
    @[JSON::Field(key: "currencyIsoCode")]
    property currency_iso_code : String?
  end

  @[JSON::Field(key: "id")]
  property id : String?
  @[JSON::Field(key: "legacyId")]
  property legacy_id : String?
  @[JSON::Field(key: "createdAt")]
  property created_at : String?
  @[JSON::Field(key: "paymentMethodSnapshot")]
  property payment_method_snapshot : String?
  @[JSON::Field(key: "paymentMethod")]
  property payment_method : String?
  @[JSON::Field(key: "amount")]
  property amount : Amount?
  # @[JSON::Field(key: "customFields")]
  # property customFields : String?
  @[JSON::Field(key: "merchantId")]
  property merchant_id : String?
  @[JSON::Field(key: "merchantAccountId")]
  property merchant_account_id : String?
  @[JSON::Field(key: "merchantName")]
  property merchant_name : String?
  @[JSON::Field(key: "merchantAddress")]
  property merchant_address : String?
  @[JSON::Field(key: "orderId")]
  property order_id : String?
  @[JSON::Field(key: "purchaseOrderNumber")]
  property purchase_order_number : String?
  @[JSON::Field(key: "status")]
  property status : String?
  @[JSON::Field(key: "riskData")]
  property risk_data : String?
  @[JSON::Field(key: "descriptor")]
  property descriptor : String?
  # @[JSON::Field(key: "statusHistory")]
  # property status_history : String?
  @[JSON::Field(key: "channel")]
  property channel : String?
  @[JSON::Field(key: "source")]
  property source : String?
  @[JSON::Field(key: "customer")]
  property customer : String?
  @[JSON::Field(key: "shipping")]
  property shipping : String?
  @[JSON::Field(key: "tax")]
  property tax : String?
  @[JSON::Field(key: "discountAmount")]
  property discount_amount : String?
  # @[JSON::Field(key: "lineItems")]
  # property lineItems : String?
  # @[JSON::Field(key: "refunds")]
  # property refunds : String?
  @[JSON::Field(key: "partialCaptureDetails")]
  property partial_capture_details : String?
  # @[JSON::Field(key: "disputes")]
  # property disputes : String?
  # @[JSON::Field(key: "facilitatorDetails")]
  # property facilitator_details : String?
  # @[JSON::Field(key: "disbursementDetails")]
  # property disbursement_details : String?
  @[JSON::Field(key: "billingAddress")]
  property billing_address : String?
  @[JSON::Field(key: "authorizationAdjustments")]
  property authorization_adjustments : String?
end
