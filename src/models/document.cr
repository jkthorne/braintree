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
    File.write(Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s, @xml)
  end

  def self.load(id)
    path = Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s
    new(XML.parse(File.read(path))) if File.exists?(path)
  end
end
