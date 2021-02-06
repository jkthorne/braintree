class Braintree::CLI::DisputeAcceptCommand
  def self.run(cli)
    success = true

    cli.object_ids.each do |dispute_id|
      BTO::Dispute::Accept.exec(dispute_id) do |op, obj|
        if obj
          cli.human_io.puts "dispute(#{dispute_id}) accepted"
        else
          success = false
          cli.human_io.puts "failed to accept dispute"
        end
      end
    end

    exit success ? 0 : 1
  end
end
