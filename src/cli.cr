require "./braintree"
require "option_parser"
require "file_utils"
require "ini"

class Braintree::CLI
  enum Command
    None
    Error
    DisputeCreate
    DisputeFind
  end

  private getter options : Array(String)
  private getter color : Bool

  def initialize(@options)
    setup_config
    @color = ENV["TERM"]? != "dumb"
  end

  def self.run(options = ARGV)
    new(options).run
  end

  def run
    command = Command::None
    opts = {} of Symbol => String

    OptionParser.parse do |parser|
      parser.banner = "Usage: bt [command] [switches]"
      parser.on("-h", "--help", "Show this help"){ puts parser }
      parser.on("-v", "--version", "Print version"){ puts parser }
      parser.on("dispute", "Subcommand for disputes") do
        parser.banner = "Usage: bt disputes [command] [switches]"
        parser.on("create", "create a new dispute") do
          command = Command::DisputeCreate
          parser.banner = "Usage: bt disputes create [switches]"
          parser.on("-a AMOUNT", "--amount AMOUNT", "set amount for dispute"){|_a| opts[:amount] = _a }
          parser.on("-n NUM", "--number NUM", "set card number for dispute"){|_n| opts[:number] = _n }
          parser.on("-e DATE", "--exp_date DATE", "set expiration date for dispute"){|_e| opts[:exp_date] = _e }
          parser.on("-s STATUS", "--status STATUS", "set expiration date for dispute (open,won,lost)"){|_s| opts[:status] = _s }
        end
        parser.on("find", "find a dispute") do
          command = Command::DisputeFind
          parser.banner = "Usage: bt disputes find [switches]"
          parser.on("-i ID", "--id=ID", "dispute id"){|_id| opts[:dispute_id] = _id }
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
    when Command::DisputeCreate
      if opts[:exp_date]?
        expiration_month, expiration_year = opts[:exp_date].split("/")
        expiration_date = Time.utc(year: expiration_year.to_i, month: expiration_month.to_i, day: 1)
      end

      dispute_klass = case opts.fetch(:status, "open")
      when "open" then Braintree::Operations::Dispute::Sandbox::OpenDispute
      when "won" then Braintree::Operations::Dispute::Sandbox::WonDispute
      when "lost" then Braintree::Operations::Dispute::Sandbox::LostDispute
      else
        raise "the status #{opts[:status]} is not a valid status"
      end
      dispute_klass.new(
        amount: opts.fetch(:amount, BT::Transaction::Sandbox::Amount.authorized),
        card_number: opts.fetch(:card_number, BT::Transaction::Sandbox::Dispute.card_number),
        card_expiration: opts.fetch(:card_expiration, BT::Transaction::Sandbox::Card.valid_expiration)
      ).exec do |op, d|
        if d
          STDERR.puts "Dispute(#{d.xpath_node("//dispute/id").not_nil!.text}) Created with options #{opts}"
        else
          STDERR.puts "Failed to create dispute with options #{opts}"
          STDERR.puts "Server status #{op.try &.response.try &.status}" if op.try &.response.try &.status
        end
      end
    when Command::DisputeFind
      BTQ::Dispute::Find.exec(opts[:dispute_id]) do |op, d|
        if d
          puts "dispute found" ## TODO output more data
        else
          STDERR.puts "failed to find dispute"
        end
      end
    else
      STDERR.puts "ERROR: you found an error in the CLI please consider submitting an issue"
      exit 1
    end
  end
  
  def setup_config
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
