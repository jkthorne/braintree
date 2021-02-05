class Braintree::Models::Transaction
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
  getter disputes = [] of Braintree::Models::Dispute
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
  # retry-ids type="array"/>
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
    @id = xml.xpath_node("./id").not_nil!.text
    @status = xml.xpath_node("./status").not_nil!.text
    @type = xml.xpath_node("./type").not_nil!.text
    @currency_iso_code = xml.xpath_node("./currency-iso-code").not_nil!.text
    @amount = xml.xpath_node("./amount").not_nil!.text
    @merchant_account_id = xml.xpath_node("./merchant-account-id").not_nil!.text
    @sub_merchant_account_id = xml.xpath_node("./sub_merchant-account-id").try &.text
    @master_merchant_account_id = xml.xpath_node("./master_merchant-account-id").try &.text
    @order_id = xml.xpath_node("./order-id").not_nil!.text
    @created_at = Time.parse_iso8601 xml.xpath_node("./created-at").not_nil!.text
    @updated_at = Time.parse_iso8601 xml.xpath_node("./updated-at").not_nil!.text
    @refund_id = xml.xpath_node("./refund-id").not_nil!.text
    @refund_ids = xml.xpath_node("./refund-ids").not_nil!.text
    @refund_transaction_id = xml.xpath_node("./refund-transaction-id").try &.text
    @authorized_transaction_id = xml.xpath_node("./authorized-transaction-id").not_nil!.text
    @settlement_batch_id = xml.xpath_node("./settlement-batch-id").not_nil!.text
    @avs_error_response_code = xml.xpath_node("./avs-error-response-code").not_nil!.text
    @avs_postal_code_response_code = xml.xpath_node("./avs-postal-code-response-code").not_nil!.text
    @avs_street_address_response_code = xml.xpath_node("./avs-street-address-response-code").not_nil!.text
    @cvv_response_code = xml.xpath_node("./cvv-response-code").not_nil!.text
    @gateway_rejection_reason = xml.xpath_node("./gateway-rejection-reason").not_nil!.text
    @processor_authorization_code = xml.xpath_node("./processor-authorization-code").not_nil!.text
    @processor_response_code = xml.xpath_node("./processor-response-code").not_nil!.text.to_i
    @processor_response_text = xml.xpath_node("./processor-response-text").not_nil!.text
    @additional_processor_response = xml.xpath_node("./additional-processor-response").not_nil!.text
    @voice_referral_number = xml.xpath_node("./voice-referral-number").not_nil!.text
    @purchase_order_number = xml.xpath_node("./purchase_order-number").try &.text
    @tax_amount = xml.xpath_node("./tax-amount").not_nil!.text
    @tax_exempt = xml.xpath_node("./tax-exempt").not_nil!.text == "true"
    @sca_exemption_requested = xml.xpath_node("./sca-exemption-requested").not_nil!.text
    @processed_with_network_token = xml.xpath_node("./processed-with-network-token").not_nil!.text == "true"
    @plan_id = xml.xpath_node("./plan-id").not_nil!.text
    @subscription_id = xml.xpath_node("./subscription-id").not_nil!.text
    @recurring = xml.xpath_node("./recurring").not_nil!.text == "true"
    @channel = xml.xpath_node("./channel").not_nil!.text
    @service_fee_amount = xml.xpath_node("./service-fee-amount").not_nil!.text
    @escrow_status = xml.xpath_node("./escrow_status").try &.text
    @payment_instrument_type = xml.xpath_node("./payment-instrument-type").not_nil!.text
    @processor_settlement_response_code = xml.xpath_node("./processor-settlement-response-code").not_nil!.text
    @processor_settlement_response_text = xml.xpath_node("./processor-settlement-response-text").not_nil!.text
    @network_response_code = xml.xpath_node("./network-response-code").not_nil!.text
    @network_response_text = xml.xpath_node("./network-response-text").not_nil!.text
    @three_d_secure_info = xml.xpath_node("./three-d-secure-info").not_nil!.text
    @ships_from_postal_code = xml.xpath_node("./ships-from-postal-code").not_nil!.text
    @shipping_amount = xml.xpath_node("./shipping-amount").not_nil!.text
    @discount_amount = xml.xpath_node("./discount-amount").not_nil!.text
    @network_transaction_id = xml.xpath_node("./network-transaction-id").not_nil!.text
    @processor_response_type = xml.xpath_node("./processor-response-type").not_nil!.text
    @authorization_expires_at = Time.parse_iso8601 xml.xpath_node("./authorization-expires-at").not_nil!.text
    @retried_transaction_id = xml.xpath_node("./retried-transaction-id").not_nil!.text
    @refunded_transaction_global_id = xml.xpath_node("./refunded-transaction-global-id").not_nil!.text
    @authorized_transaction_global_id = xml.xpath_node("./authorized-transaction-global-id").not_nil!.text
    @global_id = xml.xpath_node("./global-id").not_nil!.text
    @retried_transaction_global_id = xml.xpath_node("./retried-transaction-global-id").not_nil!.text
    @retrieval_reference_number = xml.xpath_node("./retrieval-reference-number").not_nil!.text
    installment_count = xml.xpath_node("./installment-count").not_nil!.text
    @installment_count = installment_count.to_i unless installment_count.empty?
    @response_emv_data = xml.xpath_node("./response-emv-data").not_nil!.text
    @acquirer_reference_number = xml.xpath_node("./acquirer-reference-number").not_nil!.text
    @merchant_identification_number = xml.xpath_node("./merchant-identification-number").not_nil!.text
    @terminal_identification_number = xml.xpath_node("./terminal-identification-number").not_nil!.text
    @merchant_name = xml.xpath_node("./merchant-name").not_nil!.text

    xml.xpath_nodes("./transaction/disputes").try &.each do |child|
      @disputes << Dispute.new(child)
    end
  end

  def store
    File.write((BT.data_dir / "#{id}.xml").to_s, xml)
  end

  def self.load(id)
    path = (BT.data_dir / "#{id}.xml").to_s

    if File.exists?(path)
      transaction = new(XML.parse(File.read(path)))
      Log.debug { "Transaction(#{id}) loaded from local store" }
      transaction
    else
      Log.debug { "Transaction(#{id}) failed to loaded from local store" }
      nil
    end
  end

  def output_fields(expanded = false)
    [
      id,
      status,
      type,
      amount,
      currency_iso_code,
      merchant_account_id,
      refund_id ? refund_id.not_nil! : "N/A",
      gateway_rejection_reason ? gateway_rejection_reason.not_nil! : "N/A",
      processor_response_code,
      plan_id ? plan_id.not_nil! : "N/A",
      subscription_id ? subscription_id.not_nil! : "N/A",
      recurring.to_s
    ]
  end

  def human_view(io = STDERR, expanded = false)
    data = [ output_fields(expanded) ]

    view = Tablo::Table.new(data){ |table| human_view_columns(table) }

    io.puts view
  end

  def human_view_columns(table, prefix : String = "")
    table.add_column("#{prefix}ID", width: 8 + prefix.size) { |n| n[0]}
    table.add_column("#{prefix}Status", width: 7 + prefix.size) { |n| n[1]}
    table.add_column("#{prefix}Type", width: 4 + prefix.size) { |n| n[2]}
    table.add_column("#{prefix}Amount", width: 6 + prefix.size) { |n| n[4]}
    table.add_column("#{prefix}Currency ISO", width: 12 + prefix.size) { |n| n[3]}
    table.add_column("#{prefix}Merchant Account ID", width: 19 + prefix.size) { |n| n[5]}
    table.add_column("#{prefix}Refund ID", width: 12 + prefix.size) { |n| n[6]}
    table.add_column("#{prefix}Gateway Rejection Reason", width: 24 + prefix.size) { |n| n[7]}
    table.add_column("#{prefix}Processor Response Code", width: 23 + prefix.size) { |n| n[8]}
    table.add_column("#{prefix}Plan ID", width: 8 + prefix.size) { |n| n[9]}
    table.add_column("#{prefix}Subscription ID", width: 15 + prefix.size) { |n| n[10]}
    table.add_column("#{prefix}Recurring", width: 12 + prefix.size) { |n| n[11]}
  end

  def machine_view(io = STDOUT, expanded = false)
    io.puts output_fields(expanded).map(&.to_s).join(" ")
  end

  def expand
    # TODO: request full data
  end

  def arn
    acquirer_reference_number
  end
end
