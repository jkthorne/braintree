class Braintree::CLI::Config::ShowCommand
  def self.run(cli)
    if cli.human_tty?
      cli.human_io.puts "Merchant ID(#{cli.profile}): #{BT.settings.merchant}" if cli.options[:merchant]? == "show"
      cli.human_io.puts "Public Key(#{cli.profile}): #{BT.settings.public_key}" if cli.options[:public_key]? == "show"
      cli.human_io.puts "Private Key(#{cli.profile}): #{BT.settings.private_key}" if cli.options[:private_key]? == "show"
    end
  end
end
