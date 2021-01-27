require "./braintree"
require "option_parser"
require "file_utils"
require "ini"

class Braintree::CLI
  enum Command
    None
    Banner
    Error
    DisputeAccept
    DisputeEvidence
    DisputeCreate
    DisputeFinalize
    DisputeFind
    DisputeSearch
  end

  Log = ::Log.for("CLI")

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
    ids = [] of String
    opts = {} of Symbol => String
    banner = nil

    command = Command::Banner
    main_parser = OptionParser.parse do |parser|
      parser.banner = "Usage: bt [command] [switches]"
      parser.on("-h", "--help", "Show this help") {
        command = Command::Banner
        banner = parser.to_s
      }
      parser.on("-v", "--version", "Print version") { puts parser }
      parser.on("-d", "--debug", "Print version") { ::Log.setup(:debug) }
      parser.on("dispute", "Subcommand for disputes") do
        parser.banner = "Usage: bt disputes [subcommand|ids] [switches]"
        parser.on("-h", "--help", "Show this help") {
          command = Command::Banner
          banner = parser.to_s
        }
        parser.separator("Global Values")
        parser.on("-l", "--local", "use local data") { opts[:source] = "local" }
        parser.on("-s", "--store", "persist the response") { opts[:source] = "remote" }
        parser.separator("Dispute Actions")
        parser.on("-F", "--finalize", "finalizes the dispute") { command = Command::DisputeFinalize }
        parser.on("-A", "--accept", "accepts a dispute") { command = Command::DisputeAccept }

        parser.on("create", "create a new dispute") do
          command = Command::DisputeCreate
          parser.banner = "Usage: bt disputes create [switches]"
          parser.on("-h", "--help", "Show this help") {
            command = Command::Banner
            banner = parser.to_s
          }
          parser.separator("Dispute Attributes")
          parser.on("-a AMOUNT", "--amount AMOUNT", "set amount for dispute") { |_a| opts[:amount] = _a }
          parser.on("-n NUM", "--number NUM", "set card number for dispute") { |_n| opts[:number] = _n }
          parser.on("-e DATE", "--exp_date DATE", "set expiration date for dispute") { |_e| opts[:exp_date] = _e }
          parser.on("-s STATUS", "--status STATUS", "set expiration date for dispute (open,won,lost)") { |_s| opts[:status] = _s }
        end

        parser.on("evidence", "adds file evidence") do
          command = Command::DisputeEvidence
          parser.on("-h", "--help", "Show this help") {
            command = Command::Banner
            banner = parser.to_s
          }
          parser.separator("Types")
          parser.on("-t", "--text TEXT", "adds text evidenxe") { |_t| opts[:text] = _t }
          parser.on("-f", "--file PATH", "path to file") { |_f| opts[:file] = _f }
          parser.on("-r", "--remove", "removes evidence for dispute") { |_r| opts[:remove] = _r }
        end

        parser.on("search", "searches disputes") do
          command = Command::DisputeSearch
          parser.on("-h", "--help", "Show this help") {
            command = Command::Banner
            banner = parser.to_s
          }
          parser.separator("Search Criteria")
          parser.on("-a AMOUNT", "--amount AMOUNT", "amount range (100,200)") { |_a| opts[:amount] = _a }
          parser.on("-s STATUS", "--status STATUS", "status (open,won,lost)") { |_s| opts[:status] = _s }
          parser.on("-c CASE_NUMBER", "--case CASE_NUMBER", "case number") { |_c| opts[:case_number] = _c }
          parser.on("-C CUSTOMER_ID", "--customer CUSTOMER_ID", "customer id") { |_c| opts[:customer_id] = _c }
          parser.on("-d DISBURSMENT_DATE", "--disbursment_date DISBURSMENT_DATE", "disbursment date") { |_d| opts[:disbursment_date] = _d }
          parser.on("-s EFFECTIVE_DATE", "--effective_date EFFECTIVE_DATE", "effective date") { |_e| opts[:effective_date] = _e }
          parser.on("-i ID", "--id ID", "dispute id") { |_i| opts[:dispute_id] = _i }
          parser.on("-k KIND", "--kind KIND", "kind") do |_k|
            opts[:kind] = opts[:kind]? ? "#{opts[:kind]},#{_k}" : opts[:kind]
          end
          parser.on("-m MERCHANT_ACCOUNT_ID", "--merchant_account_id MERCHANT_ACCOUNT_ID", "merchant account id") { |_k| opts[:merchant_account_id] = _k }
          parser.on("-r REASON", "--reason REASON", "reason") { |_r| opts[:reason] = _r }
          parser.on("-R REASON_CODE", "--reason_code REASON_CODE", "reason_code") { |_r| opts[:reason_code] = _r }
          parser.on("-D RECEIVED_DATE", "--received_date RECEIVED_DATE", "received date") { |_r| opts[:received_date] = _r }
          parser.on("-n REFERENCE_NUMBER", "--reference_number REFERENCE_NUMBER", "reference number") { |_r| opts[:reference_number] = _r }
          parser.on("-b REPLY_BY_DATE", "--reply_by_date REPLY_BY_DATE", "reply by date") { |_r| opts[:reply_by_date] = _r }
          parser.on("-S STATUS", "--status STATUS", "status") { |_s| opts[:status] = _s }
          parser.on("-t TRANSACTION_ID", "--transaction_id TRANSACTION_ID", "transaction_id") { |_t| opts[:transaction_id] = _t }
          parser.on("-T TRANSACTION_SOURCE", "--transaction_source TRANSACTION_SOURCE", "transaction_source") { |_t| opts[:transaction_source] = _t }
        end

        parser.unknown_args do |pre_dash, post_dash|
          Log.debug { "other arguments pre: #{pre_dash}, post: #{post_dash}" }
          if !pre_dash.empty? || !post_dash.empty?
            # TODO: maybe move to top of dispute parser
            command = Command::DisputeFind
            ids = pre_dash
          end
        end
      end

      parser.invalid_option do |flag|
        command = Command::Error
        STDERR.puts "ERROR: #{flag} is not a valid option."
        STDERR.puts parser
      end
    end
    banner ||= main_parser.to_s

    Log.debug { "command selected: #{command}" }
    case command
    when Command::Banner
      STDERR.puts banner
      exit
    when Command::Error
      exit 1
    when Command::DisputeAccept
      DisputeAcceptCommand.exec(ids)
    when Command::DisputeEvidence
      # TODO
    when Command::DisputeCreate
      DisputeCreateCommand.exec(opts)
    when Command::DisputeFinalize
      DisputeFinalizeCommand.exec(ids)
    when Command::DisputeFind
      DisputeFindCommand.exec(ids, opts)
    when Command::DisputeSearch
      # TODO
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

require "./cli/**"
