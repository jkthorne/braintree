class Braintree::CLI::DisputeSearchCommand
  def self.run(options : Hash(Symbol, String))
    BTQ::Dispute::Search.exec(options, 1) do |op, disputes|
      if disputes
        disputes.store
        render disputes
      else
        STDERR.puts "failed to search dispute"
        exit 1
      end
    end
  end

  def self.render(disputes)
    STDERR.puts "found #{disputes.total_items} dispute found"
    STDERR.puts "displaying #{disputes.disputes.size} on page #{disputes.current_page_number}"
    disputes.disputes.each do |dispute|
      STDERR.puts "Dispute(#{dispute.id}) - Status #{dispute.status}"
    end
  end
end
