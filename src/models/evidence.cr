class Braintree::Evidence
  getter id : String
  getter global_id : String
  getter category : String?
  getter comment : String?
  getter created_at : Time
  getter sent_to_processor_at : Time?
  getter sequence_number : Int32?
  getter url : String?

  getter xml : XML::Node?

  def initialize(@xml : XML::Node, @transaction : Transaction? = nil)
    @id = xml.xpath_node("./evidence/id").not_nil!.text
    @global_id = xml.xpath_node("./evidence/global-id").not_nil!.text
    @category = xml.xpath_node("./evidence/category").try &.text
    @comment = xml.xpath_node("./evidence/comment").try &.text
    @created_at = Time.parse_iso8601 xml.xpath_node("./evidence/created-at").not_nil!.text
    sent_to_processor_at = xml.xpath_node("./evidence/sent-to-processor-at")
    unless sent_to_processor_at.try &.text.empty?
      @sent_to_processor_at = Time.parse(sent_to_processor_at.not_nil!.text, "%F", Time::Location::UTC)
    end
    sequence_number = xml.xpath_node("/evidence/sequence-number").try &.text
    @sequence_number = sequence_number.try &.to_i unless sequence_number.try &.empty?
    @url = xml.xpath_node("./evidence/url").try &.text
  end

  def store
    File.write(Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s, @xml)
  end

  def self.load(id)
    path = Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s
    new(XML.parse(File.read(path))) if File.exists?(path)
  end
end
