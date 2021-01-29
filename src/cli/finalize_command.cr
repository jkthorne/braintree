class Braintree::CLI::DisputeFinalizeCommand
  def self.run(ids : Array(String))
    success = true

    ids.each do |dispute_id|
      BTO::Dispute::Finalize.exec(dispute_id) do |op, obj|
        if obj
          STDERR.puts "dispute(#{dispute_id}) finalized"
        else
          success = false
          STDERR.puts "failed to finalized dispute"
        end
      end

      exit success ? 0 : 1
    end
  end
end
