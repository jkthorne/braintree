class Braintree::Models::Disputes
  # TODO: extract page info
  getter current_page_number : Int32?
  getter page_size : Int32?
  getter total_items : Int32?

  getter disputes = [] of Models::Dispute

  getter xml : XML::Node?

  def initialize
  end

  def initialize(@xml : XML::Node)
    @current_page_number = xml.xpath_node("disputes/current-page-number").not_nil!.text.to_i
    @page_size = xml.xpath_node("disputes/page-size").not_nil!.text.to_i
    @total_items = xml.xpath_node("disputes/total-items").not_nil!.text.to_i

    disputes_xml = xml.xpath_nodes("disputes//dispute")
    # File.write "tmp.xml", disputes_xml
    if disputes_xml
      disputes_xml.each do |child|
        # File.write "tmp.xml", child
        @disputes << Dispute.new(child)
      end
    end
  end

  def store
    disputes.each &.store
  end

  def self.load(ids)
    disputes = new
    ids.each do |id|
      disputes << Dispute.load(id)
    end
    disputes
  end

  def human_view(io = STDERR)
    data = disputes.map { |d| d.output_fields }

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

  def machine_view(io = STDOUT)
    disputes.each do |d|
      io.puts d.output_fields.map(&.to_s).join(" ")
    end
  end

  def <<(dispute : Dispute)
    @disputes << dispute
  end
end
