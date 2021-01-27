class Braintree::CLI::DisputeFindCommand
  def self.exec(ids : Array(String), options : Hash(Symbol, String))
    ids.each do |dispute_id|
      if options[:source]? == "local"
        dispute = Dispute.load(dispute_id)
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
    end
  end

  def self.render(dispute)
    puts "dispute found" # TODO output more
    exit
  end
end
