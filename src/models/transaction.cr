module Braintree
  class Transaction
    getter id : String
    getter status : String
    getter type : String
    getter currency_iso_code : String
    getter amount : String
    getter merchant_account_id : String
    getter sub_merchant_account_id : String?
    getter master_merchant_account_id : String?
    getter order_id : String?
    getter created_at : Time
    getter updated_at : Time
    # getter customer
    # getter billing
    getter refund_id : String?
    getter refund_ids : String?
    getter refund_transaction_id : String?
    # getter partial_settlement_transaction_ids : Array(String)
    getter authorized_transaction_id : String?
    getter settlement_batch_id : String?
    # getter shipping
    # getter custom-fields
    getter avs_error_response_code : String?
    getter avs_postal_code_response_code : String
    getter avs_street_address_response_code : String
    getter cvv_response_code : String
    getter gateway_rejection_reason : String?
    getter processor_authorization_code : String
    getter processor_response_code : Int32
    getter processor_response_text : String
    getter additional_processor_response : String?
    getter voice_referral_number : String?
    getter purchase_order_number : String?
    getter tax_amount : String?
    getter tax_exempt : Bool
    getter sca_exemption_requested : String?
    getter processed_with_network_token : Bool
    # getter credit_card
    # getter status_history
    getter plan_id : String?
    getter subscription_id : String?
    # getter subscription
    # getter add_ons
    # getter discounts
    # getter discriptor
    getter recurring : Bool
    getter channel : String?
    getter service_fee_amount : String
    getter escrow_status : String?
    # getter disbursement_details : String?
    getter disputes = [] of Dispute
    # getter authorization-adjustments
    getter payment_instrument_type : String
    getter processor_settlement_response_code : String?
    getter processor_settlement_response_text : String?
    getter network_response_code : String
    getter network_response_text : String
    getter three_d_secure_info : String?
    getter ships_from_postal_code : String?
    getter shipping_amount : String?
    getter discount_amount : String?
    getter network_transaction_id : String
    getter processor_response_type : String
    getter authorization_expires_at : Time
    # <retry-ids type="array"/>
    getter retried_transaction_id : String?
    # getter refund_global_ids
    # getter partial_settlement_transaction_global_ids
    getter refunded_transaction_global_id : String?
    getter authorized_transaction_global_id : String?
    getter global_id : String
    # getter retry_global_ids
    getter retried_transaction_global_id : String?
    getter retrieval_reference_number : String
    getter installment_count : Int32?
    # getter installments : Array(String)
    # getter refunded_installments : Array(String)
    getter response_emv_data : String?
    getter acquirer_reference_number : String?
    getter merchant_identification_number : String
    getter terminal_identification_number : String
    getter merchant_name : String
    # getter merchant_address

    getter xml : XML::Node?

    def initialize(@xml : XML::Node)
      @id = xml.xpath_node("./transaction/id").not_nil!.text
      @status = xml.xpath_node("./transaction/status").not_nil!.text
      @type = xml.xpath_node("./transaction/type").not_nil!.text
      @currency_iso_code = xml.xpath_node("./transaction/currency-iso-code").not_nil!.text
      @amount = xml.xpath_node("./transaction/amount").not_nil!.text
      @merchant_account_id = xml.xpath_node("./transaction/merchant-account-id").not_nil!.text
      @sub_merchant_account_id = xml.xpath_node("./transaction/sub_merchant-account-id").try &.text
      @master_merchant_account_id = xml.xpath_node("./transaction/master_merchant-account-id").try &.text
      @order_id = xml.xpath_node("./transaction/order-id").not_nil!.text
      @created_at = Time.parse_iso8601 xml.xpath_node("./transaction/created-at").not_nil!.text
      @updated_at = Time.parse_iso8601 xml.xpath_node("./transaction/updated-at").not_nil!.text
      @refund_id = xml.xpath_node("./transaction/refund-id").not_nil!.text
      @refund_ids = xml.xpath_node("./transaction/refund-ids").not_nil!.text
      @refund_transaction_id = xml.xpath_node("./transaction/refund-transaction-id").try &.text
      @authorized_transaction_id = xml.xpath_node("./transaction/authorized-transaction-id").not_nil!.text
      @settlement_batch_id = xml.xpath_node("./transaction/settlement-batch-id").not_nil!.text
      @avs_error_response_code = xml.xpath_node("./transaction/avs-error-response-code").not_nil!.text
      @avs_postal_code_response_code = xml.xpath_node("./transaction/avs-postal-code-response-code").not_nil!.text
      @avs_street_address_response_code = xml.xpath_node("./transaction/avs-street-address-response-code").not_nil!.text
      @cvv_response_code = xml.xpath_node("./transaction/cvv-response-code").not_nil!.text
      @gateway_rejection_reason = xml.xpath_node("./transaction/gateway-rejection-reason").not_nil!.text
      @processor_authorization_code = xml.xpath_node("./transaction/processor-authorization-code").not_nil!.text
      @processor_response_code = xml.xpath_node("./transaction/processor-response-code").not_nil!.text.to_i
      @processor_response_text = xml.xpath_node("./transaction/processor-response-text").not_nil!.text
      @additional_processor_response = xml.xpath_node("./transaction/additional-processor-response").not_nil!.text
      @voice_referral_number = xml.xpath_node("./transaction/voice-referral-number").not_nil!.text
      @purchase_order_number = xml.xpath_node("./transaction/purchase_order-number").try &.text
      @tax_amount = xml.xpath_node("./transaction/tax-amount").not_nil!.text
      @tax_exempt = xml.xpath_node("./transaction/tax-exempt").not_nil!.text == "true"
      @sca_exemption_requested = xml.xpath_node("./transaction/sca-exemption-requested").not_nil!.text
      @processed_with_network_token = xml.xpath_node("./transaction/processed-with-network-token").not_nil!.text == "true"
      @plan_id = xml.xpath_node("./transaction/plan-id").not_nil!.text
      @subscription_id = xml.xpath_node("./transaction/subscription-id").not_nil!.text
      @recurring = xml.xpath_node("./transaction/recurring").not_nil!.text == "true"
      @channel = xml.xpath_node("./transaction/channel").not_nil!.text
      @service_fee_amount = xml.xpath_node("./transaction/service-fee-amount").not_nil!.text
      @escrow_status = xml.xpath_node("./transaction/escrow_status").try &.text
      @payment_instrument_type = xml.xpath_node("./transaction/payment-instrument-type").not_nil!.text
      @processor_settlement_response_code = xml.xpath_node("./transaction/processor-settlement-response-code").not_nil!.text
      @processor_settlement_response_text = xml.xpath_node("./transaction/processor-settlement-response-text").not_nil!.text
      @network_response_code = xml.xpath_node("./transaction/network-response-code").not_nil!.text
      @network_response_text = xml.xpath_node("./transaction/network-response-text").not_nil!.text
      @three_d_secure_info = xml.xpath_node("./transaction/three-d-secure-info").not_nil!.text
      @ships_from_postal_code = xml.xpath_node("./transaction/ships-from-postal-code").not_nil!.text
      @shipping_amount = xml.xpath_node("./transaction/shipping-amount").not_nil!.text
      @discount_amount = xml.xpath_node("./transaction/discount-amount").not_nil!.text
      @network_transaction_id = xml.xpath_node("./transaction/network-transaction-id").not_nil!.text
      @processor_response_type = xml.xpath_node("./transaction/processor-response-type").not_nil!.text
      @authorization_expires_at = Time.parse_iso8601 xml.xpath_node("./transaction/authorization-expires-at").not_nil!.text
      @retried_transaction_id = xml.xpath_node("./transaction/retried-transaction-id").not_nil!.text
      @refunded_transaction_global_id = xml.xpath_node("./transaction/refunded-transaction-global-id").not_nil!.text
      @authorized_transaction_global_id = xml.xpath_node("./transaction/authorized-transaction-global-id").not_nil!.text
      @global_id = xml.xpath_node("./transaction/global-id").not_nil!.text
      @retried_transaction_global_id = xml.xpath_node("./transaction/retried-transaction-global-id").not_nil!.text
      @retrieval_reference_number = xml.xpath_node("./transaction/retrieval-reference-number").not_nil!.text
      installment_count = xml.xpath_node("./transaction/installment-count").not_nil!.text
      @installment_count = installment_count.to_i unless installment_count.empty?
      @response_emv_data = xml.xpath_node("./transaction/response-emv-data").not_nil!.text
      @acquirer_reference_number = xml.xpath_node("./transaction/acquirer-reference-number").not_nil!.text
      @merchant_identification_number = xml.xpath_node("./transaction/merchant-identification-number").not_nil!.text
      @terminal_identification_number = xml.xpath_node("./transaction/terminal-identification-number").not_nil!.text
      @merchant_name = xml.xpath_node("./transaction/merchant-name").not_nil!.text

      xml.xpath_nodes("./transaction/disputes/dispute").try &.each do |child|
        @disputes << Dispute.new(child)
      end
    end

    def arn
      acquirer_reference_number
    end

    def store
      File.write(Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s, @xml)
    end

    def self.load(id)
      new(File.read(Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s))
    end
  end
end
