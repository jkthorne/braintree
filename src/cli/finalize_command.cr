class Braintree::CLI::DisputeFinalizeCommand
  def self.exec(ids : Array(String))
    ids.each do |dispute_id|
      BTO::Dispute::Finalize.exec(dispute_id) do |op, obj|
        if obj
          p! obj
          STDERR.puts "dispute(#{dispute_id}) finalized"
        else
          STDERR.puts "failed to finalized dispute"
          exit 1
        end
      end
      exit
    end
  end
end
