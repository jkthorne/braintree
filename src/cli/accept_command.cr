class Braintree::CLI::DisputeAcceptCommand
  def self.exec(ids : Array(String))
    ids.each do |dispute_id|
      BTO::Dispute::Accept.exec(dispute_id) do |op, obj|
        if obj
          p! obj
          STDERR.puts "dispute(#{dispute_id}) accepted"
        else
          STDERR.puts "failed to accept dispute"
          exit 1
        end
      end
    end
    exit
  end
end
