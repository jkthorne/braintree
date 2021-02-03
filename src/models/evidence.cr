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
    if raw_xml = xml
      fragment = raw_xml.xpath_node("./evidence")
      File.write((BT.data_dir / "#{id}.xml").to_s, fragment.to_s)
    end
  end

  def self.load(id)
    path = (BT.data_dir / "#{id}.xml").to_s

    if File.exists?(path)
      evidence = new(XML.parse(File.read(path)))
      Log.debug { "Evidence(#{id}) loaded from local store" }
      evidence
    else
      Log.debug { "Evidence(#{id}) failed to loaded from local store" }
      nil
    end
  end
end
