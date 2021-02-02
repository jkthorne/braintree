class Braintree::CLI::DisputeFindCommand
  def self.run(ids : Array(String), options : Hash(Symbol, String))
    ids.each do |dispute_id|
      if options[:source]? == "local"
        dispute = BT::Models::Dispute.load(dispute_id)
        render dispute if dispute
        exit
      end

      BTQ::Dispute::Find.exec(dispute_id) do |op, dispute|
        if dispute
          render dispute
        else
          STDERR.puts "failed to find dispute"
          exit 1
        end
      end

      exit
    end
  end

  def self.render(dispute)
    puts "dispute found" # TODO output more
  end
end
