class Braintree::CLI::DisputeFindCommand
  def self.exec(options : Hash(Symbol, String))
    if options[:local]? == "true"
      xml = XML.parse(File.read(Path["~/.config/bt/#{options[:dispute_id]}.xml"].expand(home: true).to_s))
      return Dispute.new(xml)
    end

    BTQ::Dispute::Find.exec(options[:dispute_id]) do |op, dispute|
      if dispute
        puts "dispute found" # # TODO output more data
        exit
      else
        STDERR.puts "failed to find dispute"
        exit 1
      end
    end
  end
end
