class Braintree::CLI::DisputeFinalizeCommand
  def self.run(cli)
    success = true

    cli.object_ids.each do |dispute_id|
      BTO::Dispute::Finalize.exec(dispute_id) do |op, obj|
        if cli.human_tty? && obj
          cli.human_io.puts "Dispute(#{dispute_id}) finalized"
        else
          success = false
          cli.human_io.puts "Dispute(#{dispute_id}) failed to finalized"
        end
      end

      exit success ? 0 : 1
    end
  end
end
