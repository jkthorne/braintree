class Braintree::Models::Document
  getter id : String
  getter content_type : String
  getter kind : String
  getter name : String
  getter size : Int32
  getter expires_at : Time

  getter xml : XML::Node?

  def initialize(@xml : XML::Node)
    @id = xml.xpath_node("./document-upload/id").not_nil!.text
    @content_type = xml.xpath_node("./document-upload/content-type").not_nil!.text
    @kind = xml.xpath_node("./document-upload/kind").not_nil!.text
    @name = xml.xpath_node("./document-upload/name").not_nil!.text
    @size = xml.xpath_node("./document-upload/size").not_nil!.text.to_i
    @expires_at = Time.parse(xml.xpath_node("./document-upload/expires-at").not_nil!.text, "%F", Time::Location::UTC)
  end

  def store
    if raw_xml = xml
      fragment = raw_xml.xpath_node("./document-upload")
      File.write((BT.data_dir / "#{id}.xml").to_s, fragment.to_s)
    end
  end

  def self.load(id)
    path = (BT.data_dir / "#{id}.xml").to_s

    if File.exists?(path)
      document = new(XML.parse(File.read(path)))
      Log.debug { "Document(#{id}) loaded from local store" }
      document
    else
      Log.debug { "Document(#{id}) failed to loaded from local store" }
      nil
    end
  end
end
