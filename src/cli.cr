require "./braintree"
require "option_parser"
require "file_utils"
require "ini"

# TODO: singilton
# TODO: remote as a method
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

  
  private property options = {} of Symbol => String
  getter options = {} of Symbol => String
  getter input_io : IO
  getter data_io : IO
  getter human_io : IO

  def initialize(@input_io = STDIN, @data_io = STDOUT, @human_io = STDERR)
    # TODO: implement status property on cli
    setup_config
  end

  def self.run
    new.run
  end

  def run
    ids = [] of String
    # options = {} of Symbol => String
    banner = nil

    command = Command::Banner
    main_parser = OptionParser.parse do |parser|
      parser.banner = "Usage: bt [command] [switches]"
      parser.on("-h", "--help", "Prints this dialog") {
        command = Command::Banner
        banner = parser.to_s
      }
      parser.on("-v", "--version", "Print version") { puts parser }
      parser.on("-d", "--debug", "show debugging information") { ::Log.setup(:debug) }
      parser.on("-s", "--silent", "do not show human readable output") { setup_null_output }

      parser.separator("Subcommands")
      parser.on("dispute", "Interact with disputes") do
        parser.banner = "Usage: bt disputes [subcommand|ids] [switches]"
        parser.on("-h", "--help", "Prints this dialog") {
          command = Command::Banner
          banner = parser.to_s
        }
        parser.separator("Global")
        parser.on("-l", "--local", "persist/use local data") { options[:source] = "local" }
        parser.on("-r", "--remote", "only use remote date") { options[:source] = "remote" }
        parser.separator("Actions")
        parser.on("-F", "--finalize", "finalizes the dispute") { command = Command::DisputeFinalize }
        parser.on("-A", "--accept", "accepts a dispute") { command = Command::DisputeAccept }

        parser.on("create", "create a new dispute") do
          # TODO: create a fail fast option
          command = Command::DisputeCreate
          parser.banner = "Usage: bt disputes create [switches]"
          parser.on("-h", "--help", "Prints this dialog") {
            command = Command::Banner
            banner = parser.to_s
          }
          parser.on("-n NUM", "--number NUM", "number of disputes to create") { |_n| options[:number] = _n }
          parser.separator("Attributes")
          parser.on("-a AMOUNT", "--amount AMOUNT", "set amount for dispute") { |_a| options[:amount] = _a }
          parser.on("-c CC_NUM", "--credit_card CC_NUM", "set card number for dispute") { |_c| options[:card_number] = _c }
          parser.on("-e DATE", "--exp_date DATE", "set expiration date for dispute") { |_e| options[:exp_date] = _e }
          parser.on("-S STATUS", "--status STATUS", "set expiration date for dispute (open,won,lost)") { |_s| options[:status] = _s }
        end

        parser.on("evidence", "adds file evidence") do
          command = Command::DisputeEvidence
          parser.on("-h", "--help", "Prints this dialog") {
            command = Command::Banner
            banner = parser.to_s
          }
          parser.separator("Types")
          parser.on("-t TEXT", "--text TEXT", "adds text evidenxe") { |_t| options[:text] = _t }
          parser.on("-f PATH", "--file PATH", "path to file") { |_f| options[:file] = _f }
          parser.on("-r ID", "--remove ID", "removes evidence for dispute") { |_id| options[:remove] = _id }
        end

        parser.separator("Subcommands")
        parser.on("search", "searches disputes") do
          command = Command::DisputeSearch
          parser.on("-h", "--help", "Prints this dialog") {
            command = Command::Banner
            banner = parser.to_s
          }
          parser.on("-X", "--expanded", "includeds transaction data") { options[:data] = "expanded" }
          parser.separator("Pagination")
          parser.on("-p NUM", "--page_num NUM", "results page number") { |_p| options[:page_num] = _p }
          parser.on("-A", "--all", "gets all results") { options[:all] = "all" }
          parser.separator("Search Criteria")
          parser.on("-a AMOUNTS", "--amount AMOUNTS", "amount_disputed range (100,200)") { |_a| options[:amounts] = _a }
          parser.on("-S STATUS", "--status STATUS", "status (open,won,lost)") { |_s| options[:status] = options[:status]? ? "#{options[:status]},#{_s}" : _s }
          parser.on("-c NUM", "--case NUM", "case number") { |_c| options[:case_number] = _c }
          parser.on("-C ID", "--customer ID", "customer id") { |_c| options[:customer_id] = _c }
          parser.on("-d DATE", "--disbursment_date DATE", "disbursment date") { |_d| options[:disbursment_date] = _d }
          parser.on("-e DATE", "--effective_date DATE", "effective date") { |_e| options[:effective_date] = _e }
          parser.on("-i ID", "--id ID", "dispute id") { |_i| options[:dispute_id] = _i }
          parser.on("-k KIND", "--kind KIND", "kind (chargeback,retrieval)") { |_k| options[:kind] = options[:kind]? ? "#{options[:kind]},#{_k}" : _k }
          parser.on("-m ID", "--merchant_account_id ID", "merchant account id") { |_k| options[:merchant_account_id] = _k }
          parser.on("-r REASON", "--reason REASON", "reason") { |_r| options[:reason] = _r }
          parser.on("-R CODE", "--reason_code CODE", "reason_code") { |_r| options[:reason_code] = _r }
          parser.on("-D DATE", "--received_date DATE", "received date") { |_r| options[:received_date] = _r }
          parser.on("-n NUM", "--reference_number NUM", "reference number") { |_r| options[:reference_number] = _r }
          parser.on("-b DATE", "--reply_by_date DATE", "reply by date") { |_r| options[:reply_by_date] = _r }
          parser.on("-t ID", "--tx_id ID", "transaction id") { |_t| options[:transaction_id] = _t }
          parser.on("-T SOURCE", "--tx_source SOURCE", "transaction source") { |_t| options[:transaction_source] = _t }
        end

        parser.unknown_args do |pre_dash, post_dash|
          Log.debug { "other arguments pre: #{pre_dash}, post: #{post_dash}" }
          if !pre_dash.empty? || !post_dash.empty?
            command = Command::DisputeFind if command == Command::Banner
            ids = pre_dash
          end
        end
      end

      parser.invalid_option do |flag|
        command = Command::Error
        human_io.puts "ERROR: #{flag} is not a valid option."
        human_io.puts parser
      end
    end
    banner ||= main_parser.to_s

    if !input_io.tty?
      ARGF.each_line do |line|
        human_io.puts "LINE: #{line}"
        ids << line.split(ENV.fetch("FS", " "))[0]
      end
    end

    Log.debug { "command selected: #{command}" }
    Log.debug { "with options: #{options}" }
    Log.debug { "with ids: #{ids}" }
    case command
    when Command::Banner
      STDERR.puts banner
      exit
    when Command::Error
      exit 1
    when Command::DisputeAccept
      DisputeAcceptCommand.run(ids)
    when Command::DisputeEvidence
      DisputeEvidenceCommand.run(ids, options)
    when Command::DisputeCreate
      DisputeCreateCommand.run(self)
    when Command::DisputeFinalize
      DisputeFinalizeCommand.run(ids)
    when Command::DisputeFind
      DisputeFindCommand.run(ids, options)
    when Command::DisputeSearch
      DisputeSearchCommand.run(self)
    else
      human_io.puts "ERROR: you found an error in the CLI please consider submitting an issue"
      exit 1
    end
  end

  def setup_null_output
    @human_io = File.open(File::NULL, "w")
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

  def color?
    error.tty?
  end
end

require "./cli/**"
