class Braintree::Dispute
  getter id : String
  getter global_id : String
  getter amount : String          # # TODO: money
  getter amount_disputed : String # # TODO: money
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
  # evidence
  # getter status_history
  # getter transaction

  getter xml : XML::Node?
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
  end

  def store
    File.write(Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s, @xml)
  end

  def self.load(id)
    path = Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s
    new(XML.parse(File.read(path))) if File.exists?(path)
  end
end
