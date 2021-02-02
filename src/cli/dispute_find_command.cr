class Braintree::CLI::DisputeFindCommand
  def self.run(cli)
    cli.object_ids.each do |dispute_id|
      if cli.options[:source]? == "local"
        dispute = BT::Models::Dispute.load(dispute_id)
        if dispute
          render(dispute, cli)
          exit
        end
      end

      BTQ::Dispute::Find.exec(dispute_id) do |op, dispute|
        if dispute
          render(dispute, cli)
        else
          STDERR.puts "failed to find dispute"
          exit 1
        end
      end

      exit
    end
  end

  # TODO: extract render into common method
  def self.render(dispute, cli)
    if cli.human_io.tty?
      dispute.human_view(cli.human_io)
    else
      dispute.machine_view(cli.data_io)
    end
  end
end
