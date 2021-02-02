class Braintree::CLI::TransactionFindCommand
  def self.run(cli)
    cli.object_ids.each do |transaction_id|
      if cli.options[:source]? == "local"
        transaction = BT::Models::Transaction.load(transaction_id)
        if transaction
          render(transaction, cli)
          exit
        end
      end

      BTQ::Transaction::Find.exec(transaction_id) do |op, transaction|
        if transaction
          render(transaction, cli)
        else
          STDERR.puts "failed to find transaction"
          exit 1
        end
      end

      exit
    end
  end

  # TODO: extract render into common method
  def self.render(transaction, cli)
    if cli.human_io.tty?
      transaction.human_view(cli.human_io)
    else
      transaction.machine_view(cli.data_io)
    end
  end
end
