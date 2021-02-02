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
    if !STDOUT.tty?
      disputes.machine_view
    else
      disputes.human_view
    end
  end
end
