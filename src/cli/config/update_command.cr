class Braintree::CLI::Config::UpdateCommand
  def self.run(cli)
    config = BT::Config.new(
      profile: cli.profile,
      enviroment: cli.options[:enviroment]?,
      merchant: cli.options[:merchant]?,
      public_key: cli.options[:public_key]?,
      private_key: cli.options[:private_key]?,
      host: cli.options[:host]?
    )

    if config.save && cli.human_tty?
      cli.human_io.puts "Successfully updated Config(#{cli.profile})"
    elsif cli.human_tty?
      cli.human_io.puts "Failed to update Config(#{cli.profile})"
    end

    exit
  end
end
