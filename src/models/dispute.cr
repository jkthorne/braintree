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
  getter transaction : Transaction?

  def initialize(@xml : XML::Node, @transaction : Transaction? = nil)
    @id = xml.xpath_node("./id").not_nil!.text
    @global_id = xml.xpath_node("./global-id").not_nil!.text
    @amount = xml.xpath_node("./amount").not_nil!.text
    @amount_disputed = xml.xpath_node("./amount-disputed").not_nil!.text
    @amount_won = xml.xpath_node("./amount-won").not_nil!.text
    @case_number = xml.xpath_node("./case-number").not_nil!.text
    @created_at = Time.parse_iso8601 xml.xpath_node("./created-at").not_nil!.text
    @currency_iso_code = xml.xpath_node("./currency-iso-code").not_nil!.text
    @date_opened = Time.parse(xml.xpath_node("./date-opened").not_nil!.text, "%F", Time::Location::UTC)
    date_won = xml.xpath_node("./date-won")
    @date_won = Time.parse(date_won.not_nil!.text, "%F", Time::Location::UTC) unless date_won.try &.text.empty?
    @processor_comments = xml.xpath_node("./processor-comments").not_nil!.text
    @kind = xml.xpath_node("./kind").not_nil!.text
    @merchant_account_id = xml.xpath_node("./merchant-account-id").not_nil!.text
    @reason = xml.xpath_node("./reason").not_nil!.text
    @reason_code = xml.xpath_node("./reason-code").not_nil!.text.to_i
    @reason_description = xml.xpath_node("./reason-description").not_nil!.text
    @received_date = Time.parse(xml.xpath_node("./received-date").not_nil!.text, "%F", Time::Location::UTC)
    @reference_number = xml.xpath_node("./reference-number").not_nil!.text
    @reply_by_date = Time.parse(xml.xpath_node("./reply-by-date").not_nil!.text, "%F", Time::Location::UTC)
    @processor_reply_by_date = Time.parse(xml.xpath_node("./processor-reply-by-date").not_nil!.text, "%F", Time::Location::UTC)
    @response_deadline = Time.parse_iso8601 xml.xpath_node("./response-deadline").not_nil!.text
    @status = xml.xpath_node("./status").not_nil!.text
    @updated_at = Time.parse_iso8601 xml.xpath_node("./updated-at").not_nil!.text
    @original_dispute_id = xml.xpath_node("./original-dispute-id").not_nil!.text

    if transaction_node = xml.xpath_node("./transaction")
      @shallow_transaction = ShallowTransaction.new(transaction_node)
    end
  end

  def expand
    @transcation.try &.expand
  end

  def store
    File.write(Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s, @xml)
  end

  def self.load(id)
    path = Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s
    new(XML.parse(File.read(path))) if File.exists?(path)
  end

  def ascii_data
    [
      id,
      amount,
      amount_disputed,
      amount_won,
      case_number,
      currency_iso_code,
      date_opened.to_s("%F"),
      date_won ? date_won : "N/A",
      kind,
      reason,
      reason_code,
      reply_by_date.to_s("%F"),
      status,
      shallow_transaction.nil? ? "N/A" : shallow_transaction.not_nil!.id 
    ]
  end

  def human_view(io = STDERR)
    data = [ ascii_data ]

    table = Tablo::Table.new(data) do |t|
      t.add_column("ID", width: 16) { |n| n[0] }
      t.add_column("Amount", width: 7) { |n| n[1] }
      t.add_column("Amount Disputed", width: 15) { |n| n[2] }
      t.add_column("Amount Won", width: 10) { |n| n[3] }
      t.add_column("Case Number", width: 14) { |n| n[4] }
      t.add_column("Code ISO", width: 8) { |n| n[5] }
      t.add_column("Date Opened", width: 11) { |n| n[6] }
      t.add_column("Date Won", width: 10) { |n| n[7] }
      t.add_column("Kind") { |n| n[8] }
      t.add_column("Reason", width: 6) { |n| n[9] }
      t.add_column("Reason Code", width: 11) { |n| n[10] }
      t.add_column("Reply By Date", width: 13) { |n| n[11] }
      t.add_column("Status", width: 8) { |n| n[12] }
      t.add_column("TX ID", width: 8) { |n| n[13] }
    end

    io.puts table
  end
end
