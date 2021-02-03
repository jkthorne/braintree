class Braintree::Models::Dispute
  module Status
    Accepted = "accepted"
    Disputed = "disputed"
    Expired  = "expired"
    Open     = "open"
    Lost     = "lost"
    Won      = "won"

    ALL = [Accepted, Disputed, Expired, Open, Lost, Won]
  end

  module Reason
    CancelledRecurringTransaction = "cancelled_recurring_transaction"
    CreditNotProcessed            = "credit_not_processed"
    Duplicate                     = "duplicate"
    Fraud                         = "fraud"
    General                       = "general"
    InvalidAccount                = "invalid_account"
    NotRecognized                 = "not_recognized"
    ProductNotReceived            = "product_not_received"
    ProductUnsatisfactory         = "product_unsatisfactory"
    TransactionAmountDiffers      = "transaction_amount_differs"
    Retrieval                     = "retrieval"
  end

  module Kind
    Chargeback     = "chargeback"
    PreArbitration = "pre_arbitration"
    Retrieval      = "retrieval"

    ALL = [Chargeback, PreArbitration, Retrieval]
  end

  module CreditCard
    Chargeback = "4023898493988028"
  end

  class ShallowTransaction
    getter id : String
    getter global_id : String
    getter amount : String
    getter created_at : String
    getter installment_count : String?
    getter order_id : String?
    getter purchase_order_number : String?
    getter payment_instrument_subtype : String

    def initialize(xml : XML::Node)
      @id = xml.xpath_node("./id").not_nil!.text
      @global_id = xml.xpath_node("./global-id").not_nil!.text
      @amount = xml.xpath_node("./amount").not_nil!.text
      @created_at = xml.xpath_node("./created-at").not_nil!.text
      @installment_count = xml.xpath_node("./installment-count").try &.text
      @order_id = xml.xpath_node("./order-id").try &.text
      @purchase_order_number = xml.xpath_node("./purchase-order-number").try &.text
      @payment_instrument_subtype = xml.xpath_node("./payment-instrument-subtype").not_nil!.text
    end
  end

  getter id : String
  getter global_id : String
  getter amount : String          # TODO: money
  getter amount_disputed : String # TODO: money
  getter amount_won : String
  getter case_number : String
  getter created_at : Time
  getter currency_iso_code : String
  getter date_opened : Time
  getter date_won : Time?
  getter processor_comments : String?
  getter kind : String
  getter merchant_account_id : String
  getter reason : String
  getter reason_code : Int32
  getter reason_description : String?
  getter received_date : Time?
  getter reference_number : String?
  getter reply_by_date : Time
  getter processor_reply_by_date : Time
  getter response_deadline : Time
  getter status : String
  getter updated_at : Time
  getter original_dispute_id : String
  # getter evidence
  # getter status_history
  # getter transaction

  getter xml : XML::Node?
  getter shallow_transaction : ShallowTransaction?
  getter full_transaction : Transaction?

  def initialize(@xml : XML::Node, @full_transaction : Transaction? = nil)
    @id = xml.xpath_node("./dispute/id").not_nil!.text
    @global_id = xml.xpath_node("./dispute/global-id").not_nil!.text
    @amount = xml.xpath_node("./dispute/amount").not_nil!.text
    @amount_disputed = xml.xpath_node("./dispute/amount-disputed").not_nil!.text
    @amount_won = xml.xpath_node("./dispute/amount-won").not_nil!.text
    @case_number = xml.xpath_node("./dispute/case-number").not_nil!.text
    @created_at = Time.parse_iso8601 xml.xpath_node("./dispute/created-at").not_nil!.text
    @currency_iso_code = xml.xpath_node("./dispute/currency-iso-code").not_nil!.text
    @date_opened = Time.parse(xml.xpath_node("./dispute/date-opened").not_nil!.text, "%F", Time::Location::UTC)
    date_won = xml.xpath_node("./dispute/date-won")
    @date_won = Time.parse(date_won.not_nil!.text, "%F", Time::Location::UTC) unless date_won.try &.text.empty?
    @processor_comments = xml.xpath_node("./dispute/processor-comments").not_nil!.text
    @kind = xml.xpath_node("./dispute/kind").not_nil!.text
    @merchant_account_id = xml.xpath_node("./dispute/merchant-account-id").not_nil!.text
    @reason = xml.xpath_node("./dispute/reason").not_nil!.text
    @reason_code = xml.xpath_node("./dispute/reason-code").not_nil!.text.to_i
    @reason_description = xml.xpath_node("./dispute/reason-description").not_nil!.text
    @received_date = Time.parse(xml.xpath_node("./dispute/received-date").not_nil!.text, "%F", Time::Location::UTC)
    @reference_number = xml.xpath_node("./dispute/reference-number").not_nil!.text
    @reply_by_date = Time.parse(xml.xpath_node("./dispute/reply-by-date").not_nil!.text, "%F", Time::Location::UTC)
    @processor_reply_by_date = Time.parse(xml.xpath_node("./dispute/processor-reply-by-date").not_nil!.text, "%F", Time::Location::UTC)
    @response_deadline = Time.parse_iso8601 xml.xpath_node("./dispute/response-deadline").not_nil!.text
    @status = xml.xpath_node("./dispute/status").not_nil!.text
    @updated_at = Time.parse_iso8601 xml.xpath_node("./dispute/updated-at").not_nil!.text
    @original_dispute_id = xml.xpath_node("./dispute/original-dispute-id").not_nil!.text

    if transaction_node = xml.xpath_node("./dispute/transaction")
      @shallow_transaction = ShallowTransaction.new(transaction_node)
    end
  end

  def expand(source = "local")
    return self if full_transaction
    return self if shallow_transaction.nil?

    BTQ::TransactionQuery.exec(shallow_transaction.not_nil!.id, source) do |op, tx|
      @full_transaction = tx if tx
    end

    self
  end

  def store
    if raw_xml = xml
      fragment = raw_xml.xpath_node(".")
      File.write(Path["~/.config/bt/tmp_search.xml"].expand(home: true).to_s, fragment.to_s)
    end
  end

  def self.load(id)
    path = Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s
    if File.exists?(path)
      dispute = new(XML.parse(File.read(path)))
      Log.debug { "Dispute(#{id}) loaded from local store" }
      dispute
    else
      Log.debug { "Dispute(#{id}) failed to loaded from local store" }
      nil
    end
  end

  def output_fields(expanded = false)
    fields = [
      id,
      amount,
      amount_disputed,
      amount_won,
      case_number,
      currency_iso_code,
      date_opened.to_s("%F"),
      date_won ? date_won.not_nil!.to_s("%F") : "N/A",
      kind,
      reason,
      reason_code,
      reply_by_date.to_s("%F"),
      status,
      shallow_transaction.nil? ? "N/A" : shallow_transaction.not_nil!.id
    ]
    fields.concat(@full_transaction.not_nil!.output_fields) if expanded && full_transaction
    fields
  end

  def human_view(io = STDERR, expanded = false)
    data = [ output_fields ]

    view = Tablo::Table.new(data) do |table|
      human_view_columns(table)
      full_transaction.not_nil!.human_view_columns(table, prefix: "TX ") if expand && full_transaction
    end

    io.puts view
  end

  def human_view_columns(table)
    table.add_column("ID", width: 16) { |n| n[0] }
    table.add_column("Amount", width: 7) { |n| n[1] }
    table.add_column("Amount Disputed", width: 15) { |n| n[2] }
    table.add_column("Amount Won", width: 10) { |n| n[3] }
    table.add_column("Case Number", width: 14) { |n| n[4] }
    table.add_column("Code ISO", width: 8) { |n| n[5] }
    table.add_column("Date Opened", width: 11) { |n| n[6] }
    table.add_column("Date Won", width: 10) { |n| n[7] }
    table.add_column("Kind") { |n| n[8] }
    table.add_column("Reason", width: 6) { |n| n[9] }
    table.add_column("Reason Code", width: 11) { |n| n[10] }
    table.add_column("Reply By Date", width: 13) { |n| n[11] }
    table.add_column("Status", width: 8) { |n| n[12] }
  end

  def machine_view(io = STDOUT, expanded = false)
    io.puts output_fields(expanded).map(&.to_s).join(" ")
  end

  def transaction
    if @full_transaction
      return full_transaction
    else
       @shallow_transaction
    end
  end
end
