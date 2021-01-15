require "./braintree"
require "option_parser"
require "file_utils"
require "ini"

class Braintree::CLI
  enum Command
    None
    Error
    Dispute
    DisputeCreate
  end

  private getter options : Array(String)
  private getter color : Bool

  def initialize(@options)
    setup ## TODO move to config module
    @color = ENV["TERM"]? != "dumb"
  end

  def self.run(options = ARGV)
    new(options).run
  end

  def run
    command = Command::None
    command_opts = {} of Symbol => String

    OptionParser.parse do |parser|
      parser.banner = "Usage: bt [command] [switches] [--] [arguments]"
      parser.on("-h", "--help", "Show this help"){ puts parser }
      parser.on("-v", "--version", "Print version"){ puts parser }
      parser.on("dispute", "Subcommand for disputes") do
        command = Command::Dispute
        parser.banner = "Usage: bt disputes [command] [switches] [--] [arguments]"

        parser.on("create", "Subcommand for disputes") do
          command = Command::DisputeCreate
          parser.banner = "Usage: bt disputes create [switches] [--] [arguments]"
          parser.on("-a AMOUNT", "--ammount=AMOUNT", "set amount for dispute"){|_a| command_opts[:amount] = _a }
          parser.on("-n NUM", "--number=NUM", "set card number for dispute"){|_n| command_opts[:number] = _n }
          parser.on("-e EXP_DATE", "--exp_date=EXP_DATE", "set experation date for dispute"){|_e| command_opts[:expiration_date] = _e }
        end
      end
      parser.invalid_option do |flag|
        command = Command::Error
        STDERR.puts "ERROR: #{flag} is not a valid option."
        STDERR.puts parser
      end
    end

    case command
    when Command::None
      exit
    when Command::Error
      exit 1
    when Command::Dispute
      exit
    when Command::DisputeCreate
      if command_opts[:expiration_date]?
        expiration_month, expiration_year = command_opts[:expiration_date].split("/")
        expiration_date = Time.utc(year: expiration_year.to_i, month: expiration_month.to_i, day: 1)
      end
      BT::Transaction.create(**BT::Transaction.factory_params(
        command_opts[:amount]?, command_opts[:number]?, expiration_date
      ))
    else
      STDERR.puts "ERROR: you found an error in the CLI please consider submitting an issue"
      exit 1
    end
  end
  
  ## TODO: move to config module
  def setup
    path = Path["~/.config/bt/config.ini"].expand(home: true)

    if File.exists?(path.to_s)
      config = INI.parse(File.read(path.to_s))
      Braintree.configure do |settings|
        settings.merchant = config.dig("braintree", "merchant")
        settings.public_key = config.dig("braintree", "public_key")
        settings.private_key = config.dig("braintree", "private_key")
      end
    else
      Braintree.configure do |settings|
        print "Enter merchant id: "
        settings.merchant = gets.to_s
        print "Enter public key: "
        settings.public_key = gets.to_s
        print "Enter private key: "
        settings.private_key = gets.to_s
      end
      FileUtils.mkdir_p(path.parent.to_s)
      File.write(path.to_s, INI.build({"braintree" => Braintree.settings.to_h}))
    end
  end
end
