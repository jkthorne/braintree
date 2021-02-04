class Braintree::CLI::Config::UpdateCommand
  def self.run(cli)
    success = BT.push_config(cli.options[:merchant]?, cli.options[:public_id]?, cli.options[:private_key]?, cli.profile)

    if success && cli.human_tty?
      cli.human_io.puts "Successfully set #{cli.profile} profile public key"
    elsif cli.human_tty?
      cli.human_io.puts "Failed to set #{cli.profile} profile public key"
    end

    exit success ? 0 : 1
  end
end
