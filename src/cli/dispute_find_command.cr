class Braintree::CLI::DisputeFindCommand
  def self.run(cli)
    cli.object_ids.each do |dispute_id|
      if cli.options[:source]? == "local"
        dispute = BT::Models::Dispute.load(dispute_id)
        if dispute
          dispute.expand if cli.options[:data]? == "expanded"
          render(dispute, cli)
          exit
        end
      end

      BTQ::Dispute::Find.exec(dispute_id, cli.options.fetch("source", "local")) do |op, dispute|
        if dispute
          dispute.expand if cli.options[:data]? == "expanded"
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
    unless cli.data_io.tty?
      dispute.machine_view(cli.data_io, expanded: cli.options[:data]? == "expanded")
    else
      dispute.human_view(cli.human_io, expanded: cli.options[:data]? == "expanded")
    end
  end
end
