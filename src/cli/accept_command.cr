class Braintree::CLI::DisputeAcceptCommand
  def self.run(ids : Array(String))
    success = true
    ids.each do |dispute_id|
      BTO::Dispute::Accept.exec(dispute_id) do |op, obj|
        if obj
          STDERR.puts "dispute(#{dispute_id}) accepted"
        else
          success = false
          STDERR.puts "failed to accept dispute"
        end
      end
    end
    exit success ? 0 : 1
  end
end
