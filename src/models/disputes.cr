class Braintree::Models::Disputes
  getter current_page_number : Int32
  getter page_size : Int32
  getter total_items : Int32

  getter disputes = [] of Dispute

  getter xml : XML::Node?

  def initialize(@xml : XML::Node, @transaction : Transaction? = nil)
    @current_page_number = xml.xpath_node("./disputes/current-page-number").not_nil!.text.to_i
    @page_size = xml.xpath_node("./disputes/page-size").not_nil!.text.to_i
    @total_items = xml.xpath_node("./disputes/total-items").not_nil!.text.to_i
    xml.xpath_nodes("./disputes/dispute").try &.each do |child|
      @disputes << Dispute.new(child)
    end
  end

  def store
    File.write(Path["~/.config/bt/tmp_search.xml"].expand(home: true).to_s, @xml)
  end

  def self.load(id)
    path = Path["~/.config/bt/#{id}.xml"].expand(home: true).to_s
    new(XML.parse(File.read(path))) if File.exists?(path)
  end
end
