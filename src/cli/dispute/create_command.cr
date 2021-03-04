class Braintree::CLI::Dispute::CreateCommand
  def self.resolve(klass, cli)
    success = true
    disputes = BT::Models::Disputes.new
    count = cli.options.fetch(:number, 1).to_i

    1.upto(count) do
      klass.new(
        amount: cli.options.fetch(:amount, BT::Transaction::Sandbox::Amount.authorized),
        card_number: cli.options.fetch(:card_number, BT::Transaction::Sandbox::Dispute.card_number),
        card_expiration: cli.options.fetch(:card_expiration, BT::Transaction::Sandbox::Card.valid_expiration)
      ).exec do |op, dispute|
        if dispute
          dispute.store
          disputes << dispute
          cli.human_io.puts "Dispute(#{dispute.id}) Created with options #{cli.options}".colorize(:green)
        else
          success = false
          if op.try &.response.try &.status
            cli.human_io.puts(
              "Failed to create Dispute options:#{cli.options} status:#{op.try &.response.try &.status}".colorize(:red)
            )
          end
          break
        end
      end
    end

    if success
      unless cli.data_io.tty?
        disputes.machine_view(cli.data_io)
      else
        disputes.human_view(cli.human_io)
      end
      exit
    else
      exit 1
    end
  end

  def self.run(cli)
    if cli.options[:exp_date]?
      expiration_month, expiration_year = cli.options[:exp_date].split("/")
      expiration_date = Time.utc(year: expiration_year.to_i, month: expiration_month.to_i, day: 1)
    end

    case cli.options.fetch(:status, "open")
    when "open" then resolve(Braintree::Dispute::OpenDispute, cli)
    when "won"  then resolve(Braintree::Dispute::WonDispute, cli)
    when "lost" then resolve(Braintree::Dispute::LostDispute, cli)
    else
      raise "the status #{cli.options[:status]} is not a valid status"
    end
  end
end
