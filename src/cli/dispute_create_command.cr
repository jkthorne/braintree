class Braintree::CLI::DisputeCreateCommand
  def self.resolve(klass, options)
    klass.new(
      amount: options.fetch(:amount, BT::Transaction::Sandbox::Amount.authorized),
      card_number: options.fetch(:card_number, BT::Transaction::Sandbox::Dispute.card_number),
      card_expiration: options.fetch(:card_expiration, BT::Transaction::Sandbox::Card.valid_expiration)
    ).exec do |op, dispute|
      if dispute
        dispute.store unless options[:discard]? == "true"
        STDERR.puts "Dispute(#{dispute.as(Dispute).id}) Created with options #{options}"
      else
        STDERR.puts "Failed to create dispute with options #{options}"
        STDERR.puts "Server status #{op.try &.response.try &.status}" if op.try &.response.try &.status
        exit 1
      end
    end
  end

  def self.exec(options : Hash(Symbol, String))
    if options[:exp_date]?
      expiration_month, expiration_year = options[:exp_date].split("/")
      expiration_date = Time.utc(year: expiration_year.to_i, month: expiration_month.to_i, day: 1)
    end

    case options.fetch(:status, "open")
    when "open" then resolve Braintree::Operations::Dispute::Sandbox::OpenDispute, options
    when "won" then resolve Braintree::Operations::Dispute::Sandbox::WonDispute, options
    when "lost" then resolve Braintree::Operations::Dispute::Sandbox::LostDispute, options
    else
      raise "the status #{options[:status]} is not a valid status"
    end
  end
end
