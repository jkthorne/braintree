class Braintree::CLI::Config::ShowCommand
  def self.run(cli)
    if cli.human_tty?
      cli.human_io.puts "Enviroment(#{cli.config.profile}): #{cli.config.enviroment}" if cli.options[:enviroment]? == "show"
      cli.human_io.puts "Host(#{cli.config.profile}): #{cli.config.host}" if cli.options[:host]? == "show"
      cli.human_io.puts "Merchant ID(#{cli.config.profile}): #{cli.config.merchant}" if cli.options[:merchant]? == "show"
      cli.human_io.puts "Public Key(#{cli.config.profile}): #{cli.config.public_key}" if cli.options[:public_key]? == "show"
      cli.human_io.puts "Private Key(#{cli.config.profile}): #{cli.config.private_key}" if cli.options[:private_key]? == "show"
    end
  end
end
