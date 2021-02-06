class Braintree::CLI::TransactionFindCommand
  def self.run(cli)
    cli.object_ids.each do |transaction_id|
      BTQ::TransactionQuery.exec(transaction_id, source: cli.options.fetch(:source, "remote")) do |op, transaction|
        if transaction
          render(transaction, cli)
          exit
        else
          cli.human_io.puts "failed to find transaction"
          exit 1
        end
      end
    end
  end

  # TODO: extract render into common method
  def self.render(transaction, cli)
    if cli.human_io.tty?
      transaction.human_view(cli.human_io, expanded: cli.options[:data]? == "expanded")
    else
      transaction.machine_view(cli.data_io, expanded: cli.options[:data]? == "expanded")
    end
  end
end
