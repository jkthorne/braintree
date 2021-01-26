class Braintree::CLI::DisputeFindCommand
  def self.exec(options : Hash(Symbol, String))
    if options[:local]? == "true"
      dispute = Dispute.load(options[:dispute_id])
      render dispute if dispute
      exit
    end

    BTQ::Dispute::Find.exec(options[:dispute_id]) do |op, dispute|
      if dispute
        render dispute
      else
        STDERR.puts "failed to find dispute"
        exit 1
      end
    end
  end

  def self.render(dispute)
    puts "dispute found" # TODO output more
    exit
  end
end
