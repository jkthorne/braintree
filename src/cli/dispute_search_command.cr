class Braintree::CLI::DisputeSearchCommand
  def self.run(cli)
    BTQ::Dispute::Search.exec(cli.options) do |op, disputes|
      if disputes
        disputes.store
        render(disputes, cli)
      else
        cli.human_io.puts "failed to search dispute"
        exit 1
      end
    end
  end

  def self.render(disputes, cli)
    cli.human_io.puts "found #{disputes.total_items} dispute found"
    cli.human_io.puts "displaying #{disputes.disputes.size} on page #{disputes.current_page_number}"
    if cli.human_io.tty?
      disputes.human_view(cli.human_io)
    else
      disputes.machine_view(cli.data_io)
    end
  end
end
