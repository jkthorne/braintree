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
    @id = xml.xpath_string("string(id[text()])")
    @status = xml.xpath_string("string(status[text()])")
    @type = xml.xpath_string("string(type[text()])")
    @currency_iso_code = xml.xpath_string("string(currency-iso-code[text()])")
    @amount = xml.xpath_string("string(amount[text()])")
    @merchant_account_id = xml.xpath_string("string(merchant-account-id[text()])")
    @sub_merchant_account_id = xml.xpath_string("string(sub_merchant-account-id[text()])")
    @master_merchant_account_id = xml.xpath_string("string(master_merchant-account-id[text()])")
    @order_id = xml.xpath_string("string(order-id[text()])")
    @created_at = Time.parse_iso8601 xml.xpath_string("string(created-at[text()])")
    @updated_at = Time.parse_iso8601 xml.xpath_string("string(updated-at[text()])")
    @refund_id = xml.xpath_string("string(refund-id[text()])")
    @refund_ids = xml.xpath_string("string(refund-ids[text()])")
    @refund_transaction_id = xml.xpath_string("string(refund-transaction-id[text()])")
    @authorized_transaction_id = xml.xpath_string("string(authorized-transaction-id[text()])")
    @settlement_batch_id = xml.xpath_string("string(settlement-batch-id[text()])")
    @avs_error_response_code = xml.xpath_string("string(avs-error-response-code[text()])")
    @avs_postal_code_response_code = xml.xpath_string("string(avs-postal-code-response-code[text()])")
    @avs_street_address_response_code = xml.xpath_string("string(avs-street-address-response-code[text()])")
    @cvv_response_code = xml.xpath_string("string(cvv-response-code[text()])")
    @gateway_rejection_reason = xml.xpath_string("string(gateway-rejection-reason[text()])")
    @processor_authorization_code = xml.xpath_string("string(processor-authorization-code[text()])")
    @processor_response_code = xml.xpath_string("string(processor-response-code[text()])").to_i
    @processor_response_text = xml.xpath_string("string(processor-response-text[text()])")
    @additional_processor_response = xml.xpath_string("string(additional-processor-response[text()])")
    @voice_referral_number = xml.xpath_string("string(voice-referral-number[text()])")
    @purchase_order_number = xml.xpath_string("string(purchase_order-number[text()])")
    @tax_amount = xml.xpath_string("string(tax-amount[text()])")
    @tax_exempt = xml.xpath_bool("boolean(tax-exempt[text()])")
    @sca_exemption_requested = xml.xpath_string("string(sca-exemption-requested[text()])")
    @processed_with_network_token = xml.xpath_bool("boolean(processed-with-network-token[text()])")
    @plan_id = xml.xpath_string("string(plan-id[text()])")
    @subscription_id = xml.xpath_string("string(subscription-id[text()])")
    @recurring = xml.xpath_bool("boolean(recurring[text()])")
    @channel = xml.xpath_string("string(channel[text()])")
    @service_fee_amount = xml.xpath_string("string(service-fee-amount[text()])")
    @escrow_status = xml.xpath_string("string(escrow_status[text()])")
    @payment_instrument_type = xml.xpath_string("string(payment-instrument-type[text()])")
    @processor_settlement_response_code = xml.xpath_string("string(processor-settlement-response-code[text()])")
    @processor_settlement_response_text = xml.xpath_string("string(processor-settlement-response-text[text()])")
    @network_response_code = xml.xpath_string("string(network-response-code[text()])")
    @network_response_text = xml.xpath_string("string(network-response-text[text()])")
    @three_d_secure_info = xml.xpath_string("string(three-d-secure-info[text()])")
    @ships_from_postal_code = xml.xpath_string("string(ships-from-postal-code[text()])")
    @shipping_amount = xml.xpath_string("string(shipping-amount[text()])")
    @discount_amount = xml.xpath_string("string(discount-amount[text()])")
    @network_transaction_id = xml.xpath_string("string(network-transaction-id[text()])")
    @processor_response_type = xml.xpath_string("string(processor-response-type[text()])")
    @authorization_expires_at = Time.parse_iso8601 xml.xpath_string("string(authorization-expires-at[text()])")
    @retried_transaction_id = xml.xpath_string("string(retried-transaction-id[text()])")
    @refunded_transaction_global_id = xml.xpath_string("string(refunded-transaction-global-id[text()])")
    @authorized_transaction_global_id = xml.xpath_string("string(authorized-transaction-global-id[text()])")
    @global_id = xml.xpath_string("string(global-id[text()])")
    @retried_transaction_global_id = xml.xpath_string("string(retried-transaction-global-id[text()])")
    @retrieval_reference_number = xml.xpath_string("string(retrieval-reference-number[text()])")
    installment_count = xml.xpath_string("string(installment-count[text()])")
    @installment_count = installment_count.to_i unless installment_count.empty?
    @response_emv_data = xml.xpath_string("string(response-emv-data[text()])")
    @acquirer_reference_number = xml.xpath_string("string(acquirer-reference-number[text()])")
    @merchant_identification_number = xml.xpath_string("string(merchant-identification-number[text()])")
    @terminal_identification_number = xml.xpath_string("string(terminal-identification-number[text()])")
    @merchant_name = xml.xpath_string("string(merchant-name[text()])")

    xml.xpath_nodes("disputes/dispute").try &.each do |child|
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
      recurring.to_s,
    ]
  end

  def human_view(io = STDERR, expanded = false)
    data = [output_fields(expanded)]

    view = Tablo::Table.new(data) { |table| human_view_columns(table) }

    io.puts view
  end

  def human_view_columns(table, prefix : String = "")
    table.add_column("#{prefix}ID", width: 8 + prefix.size) { |n| n[0] }
    table.add_column("#{prefix}Status", width: 7 + prefix.size) { |n| n[1] }
    table.add_column("#{prefix}Type", width: 4 + prefix.size) { |n| n[2] }
    table.add_column("#{prefix}Amount", width: 6 + prefix.size) { |n| n[4] }
    table.add_column("#{prefix}Currency ISO", width: 12 + prefix.size) { |n| n[3] }
    table.add_column("#{prefix}Merchant Account ID", width: 19 + prefix.size) { |n| n[5] }
    table.add_column("#{prefix}Refund ID", width: 12 + prefix.size) { |n| n[6] }
    table.add_column("#{prefix}Gateway Rejection Reason", width: 24 + prefix.size) { |n| n[7] }
    table.add_column("#{prefix}Processor Response Code", width: 23 + prefix.size) { |n| n[8] }
    table.add_column("#{prefix}Plan ID", width: 8 + prefix.size) { |n| n[9] }
    table.add_column("#{prefix}Subscription ID", width: 15 + prefix.size) { |n| n[10] }
    table.add_column("#{prefix}Recurring", width: 12 + prefix.size) { |n| n[11] }
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
